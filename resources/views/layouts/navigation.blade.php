<div class="nav-card">
    <nav class="navbar">

        <div class="navbar-inner">

            <!-- Logo -->
            <div class="logo">
                <a href="{{ route('landing') }}">
                    <img 
    src="{{ $settings && $settings->logo ? asset('storage/' . $settings->logo) : asset('images/default-logo.png') }}" 
    alt="AgriWeb Logo"
>
                    <span>UNUSU AgriWeb</span>
                </a>
            </div>

            <!-- Desktop Navigation -->
            <div class="nav-links" id="nav-links">
                <a href="{{ route('landing') }}">Home</a>
                <a href="{{ route('services') }}">services</a>
                <a href="{{ route('guest.browse') }}">Browse Products</a>
                <a href="{{ route('guest.browse') }}">Place Order</a>
                <a href="{{ route('guest') }}">FAQ</a>
                
                @if (Route::has('filament.admin.auth.login'))
                    <a href="{{ route('filament.admin.auth.login') }}" class="admin-link">
                        Admin Login
                    </a>
                @endif
            </div>

            <!-- Mobile Button -->
            <button class="mobile-btn" id="mobile-menu-button">
                ☰
            </button>
            

        </div>
        

        <!-- Mobile Menu -->
        <div class="mobile-menu" id="mobile-menu">
            <a href="{{ route('landing') }}">Home</a>
            <a href="{{ route('landing') }}">Services</a>
            
            <a href="{{ route('guest.browse') }}">Browse Products</a>
            <a href="{{ route('guest.browse') }}">Place Order</a>
            <a href="{{ route('guest') }}">FAQ</a>
          
         
        

            @if (Route::has('filament.admin.auth.login'))
                <a href="{{ route('filament.admin.auth.login') }}">Admin Login</a>
            @endif
        </div>
        <div class="mobile-overlay" id="mobile-overlay"></div>

    </nav>

   
</div>