using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Models;

namespace backend.Data
{
    public interface IDataRepository
    {
        public ManagerSingleResponse GetSingleManager(string username, string password);

        public PurchasingSingleResponse GetSinglePurchasing(string id);

        public bool PostSupplier(SupplierResponse supplier);

        public IEnumerable<CategoryReponse> GetManyCategories(string id);
    }
}
