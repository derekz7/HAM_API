namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_service
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_service()
        {
            tbl_booking = new HashSet<tbl_booking>();
        }

        [StringLength(20)]
        public string id { get; set; }

        [StringLength(200)]
        public string name { get; set; }

        [StringLength(300)]
        public string description { get; set; }

        public int? price { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_booking> tbl_booking { get; set; }
    }
}
