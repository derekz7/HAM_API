namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_appointment
    {
        [StringLength(20)]
        public string id { get; set; }

        [StringLength(20)]
        public string bid { get; set; }

        [StringLength(20)]
        public string uid { get; set; }

        [StringLength(100)]
        public string serviceName { get; set; }

        public int? orderNum { get; set; }

        [StringLength(100)]
        public string depName { get; set; }

        [StringLength(100)]
        public string room { get; set; }

        [StringLength(20)]
        public string dcid { get; set; }

        [StringLength(100)]
        public string dcName { get; set; }

        [StringLength(100)]
        public string date { get; set; }

        [StringLength(100)]
        public string time { get; set; }

        [StringLength(100)]
        public string ptName { get; set; }

        public int? price { get; set; }

        [StringLength(100)]
        public string status { get; set; }

        [StringLength(300)]
        public string reason { get; set; }
    }
}
