using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Models
{
    public class SupplierResponse
    {
        public string supplier_code { get; set; }
        public string supplier_name { get; set; }
        public string supplier_bank_account { get; set; }
        public string supplier_address { get; set; }
        public string supplier_tax_code { get; set; }
        public string partner_staff_code { get; set; }
    }
}
