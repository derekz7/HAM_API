//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class tbl_booking
    {
        public string id { get; set; }
        public Nullable<int> order_num { get; set; }
        public Nullable<System.DateTime> date { get; set; }
        public string time { get; set; }
        public string price { get; set; }
        public string status { get; set; }
        public string pt_id { get; set; }
        public string user_id { get; set; }
        public string dc_id { get; set; }
        public string sv_id { get; set; }
    
        public virtual tbl_doctor tbl_doctor { get; set; }
        public virtual tbl_patient tbl_patient { get; set; }
        public virtual tbl_service tbl_service { get; set; }
        public virtual tbl_user tbl_user { get; set; }
    }
}