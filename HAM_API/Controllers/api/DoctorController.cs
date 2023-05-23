using HAM_API.Models;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Web.Http;
using System.Web.Http.Description;

namespace HAM_API.Controllers.api
{
    public class DoctorController : ApiController
    {
        private DBContext db = new DBContext();

        // GET: api/Doctor
        [HttpGet]
        public IQueryable<tbl_doctor> GetAllDoctors()
        {
            return db.tbl_doctor;
        }

        // GET: api/Doctor/5
        [HttpGet]
        [ResponseType(typeof(tbl_doctor))]
        public IHttpActionResult GetDoctorById(string id)
        {
            tbl_doctor tbl_doctor = db.tbl_doctor.Find(id);
            if (tbl_doctor == null)
            {
                return NotFound();
            }

            return Ok(tbl_doctor);
        }

        [HttpGet]
        public List<tbl_doctor> GetDoctorByDepartment(int depid)
        {
            return db.tbl_doctor.Where(x => x.dep_id == depid).ToList();

        }

        // PUT: api/Doctor/5
        [HttpPut]
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdateDoctor(string id, tbl_doctor tbl_doctor)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_doctor.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_doctor).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_doctorExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Doctor
        [HttpPost]
        [ResponseType(typeof(tbl_doctor))]
        public IHttpActionResult CreateDoctor(tbl_doctor tbl_doctor)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_doctor.Add(tbl_doctor);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (tbl_doctorExists(tbl_doctor.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = tbl_doctor.id }, tbl_doctor);
        }

        // DELETE: api/Doctor/5
        [HttpDelete]
        [ResponseType(typeof(tbl_doctor))]
        public IHttpActionResult DeleteDoctor(string id)
        {
            tbl_doctor tbl_doctor = db.tbl_doctor.Find(id);
            if (tbl_doctor == null)
            {
                return NotFound();
            }

            db.tbl_doctor.Remove(tbl_doctor);
            db.SaveChanges();

            return Ok(tbl_doctor);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_doctorExists(string id)
        {
            return db.tbl_doctor.Count(e => e.id == id) > 0;
        }
    }
}