using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace TecnologiasMovilesApi.Services.DataBase.Repository
{
    public interface IRepository<TEntity, in TKey> where TEntity : class where TKey : IComparable
    {
        TEntity this [TKey key] { get; set; }
        TEntity Get(TKey key);
        IEnumerable<TEntity> GetAll();
        IEnumerable<TEntity> Find(Expression<Func<TEntity, bool>> predicate);
        TEntity SingleOrDefault(Expression<Func<TEntity, bool>> predicate);
        void Add(TEntity entity);
        void Update(TEntity entity);
        void AddRange(IEnumerable<TEntity> entities);
        void Remove(TEntity entity);
        void Remove(TKey key);
        void RemoveRange(IEnumerable<TEntity> entities);
        bool Exists(TKey key);
    }
}