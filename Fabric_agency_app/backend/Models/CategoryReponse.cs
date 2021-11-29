using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Models
{
    public class CategoryReponse
    {
        public string category_code { get; set; }
        public string category_name { get; set; }
        public string color { get; set; }
        public int quantity { get; set; }
        public string supplier_code { get; set; }
        public string supply_quantity { get; set; }
        public DateTime supply_date { get; set; }
        public int supply_price { get; set; }
    }
}
