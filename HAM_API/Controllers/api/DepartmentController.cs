using HAM_API.Models;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Web.Http;
using System.Web.Http.Description;

namespace HAM_API.Controllers.api
{
    public class DepartmentController : ApiController
    {
        private DBContext db = new DBContext();


        [HttpGet]
        [Route("api/Department/GetAllDepartments")]
        public IQueryable<tbl_department> GetAllDepartments()
        {
            return db.tbl_department;
        }

        [HttpGet]
        [ResponseType(typeof(tbl_department))]
        public IHttpActionResult GetDepartmentById(string id)
        {
           tbl_department dep = db.tbl_department.Where(x => x.id == id).FirstOrDefault();
            if (dep == null)
            {
                return NotFound();
            }

            return Ok(dep);
        }
        [HttpGet]
        [ResponseType(typeof(tbl_department))]
        public IHttpActionResult GetDepByDoctor(string id)
        {
            var department = (from d in db.tbl_doctor
                              join dep in db.tbl_department on d.dep_id equals dep.id
                              where d.id == id
                              select dep).FirstOrDefault();

            return Ok(department);
        }


        [HttpPut]
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdateDepartment(string id, tbl_department tbl_department)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_department.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_department).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_departmentExists(id))
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

        [HttpPost]
        [ResponseType(typeof(tbl_department))]
        public IHttpActionResult CreateDepartment(tbl_department dep)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_department.Add(dep);
            try
            {
                db.SaveChanges();
            }
            catch(DbUpdateException)
            {
                if (tbl_departmentExists(dep.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = dep.id }, dep);
        }

        [HttpDelete]
        [ResponseType(typeof(tbl_department))]
        public IHttpActionResult DeleteDepartment(string id)
        {
            tbl_department dep = db.tbl_department.Find(id);
            if (dep == null)
            {
                return NotFound();
            }

            db.tbl_department.Remove(dep);
            db.SaveChanges();

            return Ok(dep);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_departmentExists(string id)
        {
            return db.tbl_department.Count(e => e.id == id) > 0;
        }
    }
}