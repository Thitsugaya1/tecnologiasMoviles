using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using TecnologiasMovilesApi.Models;

namespace TecnologiasMovilesApi.Repository
{
    public class Repository<TEntity, TKey> where TEntity : class where TKey : IComparable
    {
        protected readonly ApplicationDbContext Context;
        public Repository(ApplicationDbContext context) => Context = context;

        public TEntity this[TKey index]
        {
            get => Get(index);
            set { Update(value); Context.SaveChanges(); }
        }
        private TEntity Get(TKey key) => Context.Set<TEntity>().Find(key);
        public IQueryable<TEntity> GetAll() => Context.Set<TEntity>();
        public IQueryable<TEntity> Find(Expression<Func<TEntity, bool>> predicate) 
            =>Context.Set<TEntity>().Where(predicate);
        public TEntity SingleOrDefault(Expression<Func<TEntity, bool>> predicate) 
            =>Context.Set<TEntity>().SingleOrDefault(predicate);
        public void Add(TEntity entity) => Context.Set<TEntity>().Add(entity);
        private void Update(TEntity entity) => Context.Set<TEntity>().Update(entity);
        public void AddRange(IEnumerable<TEntity> entities) => Context.Set<TEntity>().AddRange(entities);
        public void Remove(TEntity entity) => Context.Set<TEntity>().Remove(entity);
        public void RemoveRange(IEnumerable<TEntity> entities) => Context.Set<TEntity>().RemoveRange(entities);
    }
}