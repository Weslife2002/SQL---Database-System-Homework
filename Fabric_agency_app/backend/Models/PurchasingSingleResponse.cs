using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Models
{
    public class PurchasingSingleResponse
    {
        public string category_code { get; set; }
        public string supplier_code { get; set; }
        public string supplier_name{ get; set; }
        public string supplier_bank_account { get; set; }
        public string supplier_address { get; set; }
        public string supplier_tax_code { get; set; }
        public IEnumerable<string> phoneNumber { get; set; }
    }
}
