using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Models;
using backend.Data;

namespace backend.Controllers
{
   
    [Route("api/[controller]")]
    [ApiController]
    public class ManagerController : ControllerBase
    {
        private readonly IDataRepository _dataRepository;

        public ManagerController(IDataRepository dataRepository)
        {
            _dataRepository = dataRepository;
        }


        [HttpPost]
        [Route("supplier")]
        public ActionResult<SupplierResponse> PurchasingResponse(SupplierResponse supplier)
        {
            try
            {
                var result = _dataRepository.PostSupplier(supplier);
                if (result)
                {
                    return supplier;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        [HttpGet]
        [Route("supplier")]
        public ActionResult<PurchasingSingleResponse> PurchasingResponse(string id)
        {
            var purchase = _dataRepository.GetSinglePurchasing(id);
            try
            {
                if (purchase != null)
                {
                    return purchase;
                }
                else
                {
                    return null;
                }
            }
            catch(Exception ex)
            {
                return null;
            }
        }

        [HttpPost]
        [Route("login")]
        public ActionResult<ManagerSingleResponse> Login(LoginRequest data)
        {
            var manager = _dataRepository.GetSingleManager(data.username, data.password);
            try
            {
                if (manager != null)
                {
                    return manager;
                }
                else
                {
                    return null;
                }
            }
            catch(Exception ex)
            {
                return null;
            }
        }

        [HttpGet]
        [Route("supplier/categories")]
        public IEnumerable<CategoryReponse> GetManyCategories(string id)
        {
            var categories = _dataRepository.GetManyCategories(id);
            try
            {
                if (categories != null)
                {
                    return categories;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }



    }
}
