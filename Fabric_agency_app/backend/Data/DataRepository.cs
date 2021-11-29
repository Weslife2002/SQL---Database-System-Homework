using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using backend.Models;
using Microsoft.Extensions.Configuration;
using Dapper;
namespace backend.Data
{
    public class DataRepository : IDataRepository
    {
        private readonly string _connectionString;

        public DataRepository(IConfiguration configuration)
        {
            _connectionString = configuration["ConnectionStrings:DefaultConnection"];
        }

        public ManagerSingleResponse GetSingleManager(string username, string password)
        {
            using(var connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                try
                {
                    ManagerSingleResponse rs = connection.QueryFirstOrDefault<ManagerSingleResponse>(@"EXEC dbo.Manager_GetSingle @username = @manager_username, @password = @manager_password", new
                    {
                        manager_username = username,
                        manager_password = password
                    });
                    if (rs != null)
                        return rs;
                    return null;
                }
                catch(Exception err)
                {
                    return null;
                }
                
            }
        }

        public IEnumerable<PhoneResponse> GetPhoneNumber(string id)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                try
                {
                   var rs = connection.Query<PhoneResponse>(@"EXEC dbo.Search_phonenumber @supplierId = @supplierId", new
                    {
                        supplierId = id
                    });
                    if (rs != null)
                        return rs;
                     
                    return null;
                }
                catch (Exception err)
                {
                    return null;
                }
            }
        }

        public PurchasingSingleResponse GetSinglePurchasing(string id)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                var res = connection.QueryFirstOrDefault<PurchasingSingleResponse>(@"EXEC dbo.Search_purchasing @CatCode = @id", new
                {
                    id = id
                });

                if (res != null)
                {
                    res.phoneNumber = connection.Query<string>(@"EXEC dbo.Search_phonenumber @supplierId = @id", new
                    {
                        id = res.supplier_code
                    });

                    return res;

                }
                return null;
            }
        }

        public IEnumerable<CategoryReponse> GetManyCategories(string id)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                try
                {
                    var result = connection.Query<CategoryReponse>(@"EXEC dbo.List_Categories @supplierID = @id", new
                    {
                        id = id
                    });

                    return result;
                }
                catch(Exception err)
                {
                    throw err;
                }
            }
        }

        public bool PostSupplier(SupplierResponse supplier)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                try
                {
                    connection.Query<bool>(@"EXEC dbo.Insert_supplier @supplier_code = @supplier_code, @supplier_name = @supplier_name, @supplier_bank_account = @supplier_bank_account, @supplier_address = @supplier_address, @supplier_tax_code = @supplier_tax_code, @partner_staff_code = @partner_staff_code", new
                    {
                        supplier_code = supplier.supplier_code,
                        supplier_name = supplier.supplier_name,
                        supplier_bank_account = supplier.supplier_bank_account,
                        supplier_address = supplier.supplier_address,
                        supplier_tax_code = supplier.supplier_tax_code,
                        partner_staff_code = supplier.partner_staff_code
                    });

                    return true;
                    
                }
                catch (Exception err)
                {
                    return false;
                }
                
            }
        }
    }
}
