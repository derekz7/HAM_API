using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using HAM_API.Models;

namespace HAM_API.Controllers.api
{
    public class PatientController : ApiController
    {
        private DBContext db = new DBContext();

        // GET: api/Patient
        public IQueryable<tbl_patient> GetAllPatients()
        {
            return db.tbl_patient;
        }

        // GET: api/Patient/5
        [ResponseType(typeof(tbl_patient))]
        public IHttpActionResult GetPatientById(string id)
        {
            tbl_patient tbl_patient = db.tbl_patient.Find(id);
            if (tbl_patient == null)
            {
                return NotFound();
            }

            return Ok(tbl_patient);
        }

        
        public IHttpActionResult GetPatientsByUser(string userId)
        {
            List<tbl_patient> tbl_patients = db.tbl_patient.Where(x => x.user_id == userId).ToList();
            if (tbl_patients == null || tbl_patients.Count == 0)
            {
                return NotFound();
            }

            return Ok(tbl_patients);
        }

        // PUT: api/Patient/5
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdatePatient(string id, tbl_patient tbl_patient)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_patient.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_patient).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_patientExists(id))
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

        // POST: api/Patient
        [ResponseType(typeof(tbl_patient))]
        public IHttpActionResult CreatePatient(tbl_patient tbl_patient)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_patient.Add(tbl_patient);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (tbl_patientExists(tbl_patient.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = tbl_patient.id }, tbl_patient);
        }

        // DELETE: api/Patient/5
        [ResponseType(typeof(tbl_patient))]
        public IHttpActionResult DeletePatient(string id)
        {
            tbl_patient tbl_patient = db.tbl_patient.Find(id);
            if (tbl_patient == null)
            {
                return NotFound();
            }

            db.tbl_patient.Remove(tbl_patient);
            db.SaveChanges();

            return Ok(tbl_patient);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_patientExists(string id)
        {
            return db.tbl_patient.Count(e => e.id == id) > 0;
        }
    }
}