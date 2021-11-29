using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Models
{
    public class LoginRequest
    {
        public string username { get; set; }
        public string password { get; set; }
    }
}
