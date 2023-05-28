namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_user
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_user()
        {
            tbl_booking = new HashSet<tbl_booking>();
            tbl_patient = new HashSet<tbl_patient>();
            tbl_prescription = new HashSet<tbl_prescription>();
        }

        [StringLength(20)]
        public string id { get; set; }

        [StringLength(20)]
        [Required(ErrorMessage = "The username field is required.")]
        public string username { get; set; }

        [StringLength(100)]
        [Required(ErrorMessage = "The name field is required.")]
        public string name { get; set; }

        [StringLength(20)]
        [Required(ErrorMessage = "The password field is required.")]
        public string pw { get; set; }

        [StringLength(100)]
        public string email { get; set; }

        public int? role_id { get; set; }

        [StringLength(10)]
        [Required(ErrorMessage = "The phone number ")]
        public string p_number { get; set; }

        [Column(TypeName = "text")]
        public string img { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_booking> tbl_booking { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_patient> tbl_patient { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_prescription> tbl_prescription { get; set; }

        public virtual tbl_role tbl_role { get; set; }
    }
}
