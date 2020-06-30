namespace TecnologiasMovilesApi.ViewModels
{
    public class RegisterViewModel: LoginViewModel
    {
        public string UserName { get; set; }
        public string ConfirmPassword { get; set; }
    }

		public class LoginViewModel {
			public string Email {get; set;}
			public string Password { get; set; }
		}
}
