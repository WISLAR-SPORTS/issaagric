<?php

namespace App\Http\Controllers;
use App\Models\HeroSection;
use App\Models\Feature;
use App\Models\Stat;

use App\Models\Faq;

use App\Http\Controllers\Controller;


class LandingPageController extends Controller
{
    public function index()
    {
        return view('landing', [
            'hero' => HeroSection::first(),
            'features' => Feature::all(),

            'stats' => Stat::orderBy('sort_order')->get(),

            
            'faqs' => Faq::where('is_active', true)
                        ->orderBy('sort_order')
                        ->get(),
        ]);
    }
}
