using System.Collections.Generic;

namespace TecnologiasMovilesApi.ViewModels
{
    public class ResponseViewModel
    {
        public object Message { get; set; }
        public bool Success { get; set; }

        public IEnumerable<string> Errors { get; set; }
        public ResponseViewModel(object message, bool success, IEnumerable<string> errors = null)
        {
            Message = message;
            Success = success;
            Errors = errors;
        }
    }
}