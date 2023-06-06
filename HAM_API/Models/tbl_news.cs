namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_news
    {
        [StringLength(20)]
        public string id { get; set; }

        [StringLength(200)]
        public string title { get; set; }

        [Column(TypeName = "ntext")]
        public string body { get; set; }

        [Column(TypeName = "ntext")]
        public string imgUrl { get; set; }

        [StringLength(20)]
        public string postDate { get; set; }

        [Column(TypeName = "text")]
        public string Url { get; set; }
    }
}
