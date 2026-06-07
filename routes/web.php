<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\GuestController;
use App\Http\Controllers\ServiceExportController;

use App\Http\Controllers\FarmerExportController;
use App\Http\Controllers\UserExportController;
use App\Http\Controllers\LandingPageController;
//use App\Http\Controllers\YourController;
use App\Http\Controllers\FaqQuestionController;
Route::get('/', function () {
    return env('APP_KEY'); // just to test env loading
});

Route::get('/ask-question', [FaqQuestionController::class, 'create'])->name('ask');
Route::post('/ask-question', [FaqQuestionController::class, 'store']);

use App\Http\Controllers\ServiceController;
use App\Http\Controllers\FaqController;

Route::get('/faqs', [FaqController::class, 'index'])->name('guest');

Route::get('/services', [ServiceController::class, 'index'])->name('services');

Route::get('/services/{slug}', [ServiceController::class, 'show'])->name('services.show');



Route::get('/', [LandingPageController::class, 'index'])->name('landing');
Route::get('/farmers/export/excel', [FarmerExportController::class, 'exportExcel'])
    ->name('farmers.export.excel');

Route::get('/farmers/export/pdf', [FarmerExportController::class, 'exportPdf'])
    ->name('farmers.export.pdf');

Route::get('/users/export/pdf', [UserExportController::class, 'exportPdf'])
    ->name('users.export.pdf');
Route::get('/users/export/excel', [UserExportController::class, 'exportExcel'])
    ->name('users.export.excel');

Route::get('/users/export/csv', [UserExportController::class, 'exportCsv'])
    ->name('users.export.csv');





Route::get('/services/export/pdf', [ServiceExportController::class, 'exportPdf'])
    ->name('services.export.pdf');
// Route for the landing page

// Route for the dashboard
Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

// Authenticated routes
Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// Guest routes
Route::get('/browse', [ProductController::class, 'index'])->name('guest.browse');
use App\Http\Controllers\OrderController;

Route::get('/order/{product}', [OrderController::class, 'create'])->name('orders.create');
Route::post('/order', [OrderController::class, 'store'])->name('orders.store');

require __DIR__.'/auth.php';