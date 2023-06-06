using HAM_API.Models;
using System;
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
    public class UserController : ApiController
    {
        private DBContext db = new DBContext();


        [HttpGet]
        public IQueryable<tbl_user> GetAllUsers()
        {
            return db.tbl_user;
        }

        [HttpGet]
        public tbl_user Login(string username, string password)
        {
            tbl_user user = db.tbl_user.Where(e => e.username == username && e.pw == password).FirstOrDefault();
            return user;
        }

        [HttpGet]
        [ResponseType(typeof(tbl_user))]
        public IHttpActionResult GetUserByUsername(string username)
        {
            tbl_user tbl_user = db.tbl_user.Where(x => x.username == username).FirstOrDefault();
            if (tbl_user == null)
            {
                return NotFound();
            }

            return Ok(tbl_user);
        }


        [HttpGet]
        public List<tbl_patient> GetAllPatients(string userId)
        {
            List<tbl_patient> patients = new List<tbl_patient>();
            patients = db.tbl_patient.Where(x => x.user_id == userId).ToList();
            return patients;
        }

        // GET: api/User/5
        [HttpGet]
        [ResponseType(typeof(tbl_user))]
        public IHttpActionResult GetUserById(string id)
        {
            tbl_user tbl_user = db.tbl_user.Where(x => x.id == id).FirstOrDefault();
            if (tbl_user == null)
            {
                return NotFound();
            }

            return Ok(tbl_user);
        }

        // PUT: api/User/5
        [HttpPut]
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdateUser(string id, tbl_user tbl_user)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_user.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_user).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_userExists(id))
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

        // POST: api/User
        [HttpPost]
        [ResponseType(typeof(tbl_user))]
        public IHttpActionResult CreateUser(tbl_user tbl_user)
        {
            string id = "u-" + Guid.NewGuid().ToString("N").Substring(0, 18);
            tbl_user.id = id;
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_user.Add(tbl_user);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (tbl_userExists(tbl_user.id) || tbl_userEmailExists(tbl_user.email))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = tbl_user.id }, tbl_user);
        }


        // DELETE: api/User/5
        [HttpDelete]
        [ResponseType(typeof(tbl_user))]
        public IHttpActionResult DeleteUser(string id)
        {
            tbl_user tbl_user = db.tbl_user.Find(id);
            if (tbl_user == null)
            {
                return NotFound();
            }

            db.tbl_user.Remove(tbl_user);
            db.SaveChanges();

            return Ok(tbl_user);
        }


        [HttpDelete]
        public IHttpActionResult DeleteAllPatients(string userid)
        {
            List<tbl_patient> patients = db.tbl_patient.Where(x => x.user_id == userid).ToList();

            foreach (tbl_patient p in patients)
            {
                List<tbl_patientRelative> relations = db.tbl_patientRelative.Where(x => x.pt_id == p.id).ToList();
                db.tbl_patientRelative.RemoveRange(relations);
            }
            if (patients == null)
            {
                return NotFound();
            }
            else
            {
                //Delete all patient relative of each patient
                foreach (tbl_patient p in patients)
                {
                    List<tbl_patientRelative> relations = db.tbl_patientRelative.Where(x => x.pt_id == p.id).ToList();
                    db.tbl_patientRelative.RemoveRange(relations);
                }

                db.tbl_patient.RemoveRange(patients);
                db.SaveChanges();
                return Ok(patients);
            }

        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_userExists(string id)
        {
            return db.tbl_user.Count(e => e.id == id) > 0;
        }

        private bool tbl_usernameExists(string username)
        {
            return db.tbl_user.Count(e => e.username == username) > 0;
        }

        private bool tbl_userEmailExists(string email)
        {
            return db.tbl_user.Count(e => e.email == email) > 0;
        }

        private bool tbl_patientExists(string id)
        {
            return db.tbl_patient.Count(e => e.id == id) > 0;
        }
    }
}