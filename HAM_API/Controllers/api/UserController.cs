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
    public class UserController : ApiController
    {
        private DBContext db = new DBContext();

        public IQueryable<tbl_user> GetAllUsers()
        {
            return db.tbl_user;
        }

        [HttpGet]
        public List<tbl_patient> GetPatients(string userId)
        {
            List<tbl_patient> patients = new List<tbl_patient>();
            patients = db.tbl_patient.Where(x => x.user_id == userId).ToList();
            return patients;
        }

        // GET: api/User/5
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
        [ResponseType(typeof(tbl_user))]
        public IHttpActionResult CreateUser(tbl_user tbl_user)
        {
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
                if (tbl_userExists(tbl_user.id))
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
    }
}