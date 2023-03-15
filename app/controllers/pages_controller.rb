class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]
  def home
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def my_profile
    @user = current_user
    @fa_map = {
      'Ruby' => 'fa-sharp fa-regular fa-gem',
      'Shell' => 'fas fa-terminal',
      'Vue' => 'fab fa-vuejs',
      'ActionScript' => 'fab fa-ioxhost',
      'Ada' => 'fas fa-braille',
      'AppleScript' => 'fab fa-apple',
      'ASP.NET' => 'fas fa-code',
      'Assembly' => 'fas fa-cogs',
      'Awk' => 'fas fa-code-branch',
      'Bash' => 'fas fa-terminal',
      'C' => 'fas fa-code',
      'C#' => 'fab fa-windows',
      'C++' => 'fab fa-cuttlefish',
      'Clojure' => 'fab fa-leanpub',
      'CoffeeScript' => 'fab fa-simplybuilt',
      'CSS' => 'fab fa-css3-alt',
      'D' => 'fab fa-d-and-d',
      'Dart' => 'fab fa-dart',
      'Elixir' => 'fab fa-phoenix-framework',
      'Elm' => 'fab fa-elm',
      'Erlang' => 'fab fa-erlang',
      'F#' => 'fas fa-code',
      'Fortran' => 'fas fa-braille',
      'Go' => 'fab fa-google',
      'Groovy' => 'fab fa-groovy',
      'Haskell' => 'fab fa-haskell',
      'HTML' => 'fab fa-html5',
      'Java' => 'fab fa-java',
      'JavaScript' => 'fab fa-js-square',
      'Julia' => 'fab fa-julia',
      'Kotlin' => 'fab fa-kotlin',
      'Lua' => 'fab fa-lua',
      'MATLAB' => 'fas fa-square',
      'Objective-C' => 'fab fa-apple',
      'OCaml' => 'fas fa-code-branch',
      'Perl' => 'fab fa-perl',
      'PHP' => 'fab fa-php',
      'PowerShell' => 'fas fa-terminal',
      'Python' => 'fab fa-python',
      'R' => 'fab fa-r-project',
      'Rust' => 'fab fa-rust',
      'Scala' => 'fab fa-scala',
      'Scheme' => 'fas fa-code',
      'SQL' => 'fas fa-database',
      'Swift' => 'fab fa-swift',
      'TypeScript' => 'fab fa-js-square',
      'VB.NET' => 'fab fa-windows',
      'Vim script' => 'fab fa-vimeo-v',
      'Visual Basic' => 'fab fa-vnv',
      'WebAssembly' => 'fas fa-code',
      'XML' => 'fas fa-code',
      'XSLT' => 'fas fa-code'
    }
    render 'show'
  end

  def my_bookings
    @bookings = current_user.bookings_as_booker + current_user.bookings_as_bookee
    @availabilities = current_user.availabilities
  end

  def my_settings
    render '/devise/registrations/edit'
  end

  def show
    @user = User.find(params[:id])
    @follow = Follow.where(follower: current_user, following: @user)
    @fa_map = {
      'Ruby' => 'fa-sharp fa-regular fa-gem',
      'Shell' => 'fas fa-terminal',
      'Vue' => 'fab fa-vuejs',
      'ActionScript' => 'fab fa-ioxhost',
      'Ada' => 'fas fa-braille',
      'AppleScript' => 'fab fa-apple',
      'ASP.NET' => 'fas fa-code',
      'Assembly' => 'fas fa-cogs',
      'Awk' => 'fas fa-code-branch',
      'Bash' => 'fas fa-terminal',
      'C' => 'fas fa-code',
      'C#' => 'fab fa-windows',
      'C++' => 'fab fa-cuttlefish',
      'Clojure' => 'fab fa-leanpub',
      'CoffeeScript' => 'fab fa-simplybuilt',
      'CSS' => 'fab fa-css3-alt',
      'D' => 'fab fa-d-and-d',
      'Dart' => 'fab fa-dart',
      'Elixir' => 'fab fa-phoenix-framework',
      'Elm' => 'fab fa-elm',
      'Erlang' => 'fab fa-erlang',
      'F#' => 'fas fa-code',
      'Fortran' => 'fas fa-braille',
      'Go' => 'fab fa-google',
      'Groovy' => 'fab fa-groovy',
      'Haskell' => 'fab fa-haskell',
      'HTML' => 'fab fa-html5',
      'Java' => 'fab fa-java',
      'JavaScript' => 'fab fa-js-square',
      'Julia' => 'fab fa-julia',
      'Kotlin' => 'fab fa-kotlin',
      'Lua' => 'fab fa-lua',
      'MATLAB' => 'fas fa-square',
      'Objective-C' => 'fab fa-apple',
      'OCaml' => 'fas fa-code-branch',
      'Perl' => 'fab fa-perl',
      'PHP' => 'fab fa-php',
      'PowerShell' => 'fas fa-terminal',
      'Python' => 'fab fa-python',
      'R' => 'fab fa-r-project',
      'Rust' => 'fab fa-rust',
      'Scala' => 'fab fa-scala',
      'Scheme' => 'fas fa-code',
      'SQL' => 'fas fa-database',
      'Swift' => 'fab fa-swift',
      'TypeScript' => 'fab fa-js-square',
      'VB.NET' => 'fab fa-windows',
      'Vim script' => 'fab fa-vimeo-v',
      'Visual Basic' => 'fab fa-vnv',
      'WebAssembly' => 'fas fa-code',
      'XML' => 'fas fa-code',
      'XSLT' => 'fas fa-code'
    }
    @room_name = get_name(@user, current_user)
    @room = Room.find_by(name: @room_name)
  end

  def settings
  end

  def index
    if params[:query].present?
      sql_query = "user_name ILIKE :query OR github_nickname ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    else
      @users = User.all
    end
  end

  def get_name(user1, user2)
    "Chat: #{user1.github_nickname} & #{user2.github_nickname}"
  end
end
