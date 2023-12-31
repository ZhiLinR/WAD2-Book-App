<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//PUBLIC ROUTES-------------------------------------------------------------
Route::get('/', function () {
    return to_route('login');
    /* return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]); */
});
//Book Catalogue
Route::get('/catalogue', function () {
    return Inertia::render('BookCatalogue');
})->name('catalogue');


Route::get('/register', function () {
    return Inertia::render('Register');
})->name('register');

//USER RESTRICTED ROUTES-------------------------------------------------------------
//Dashboard
Route::get('/home', function () {
    return Inertia::render('Homepage');
})->middleware(['auth', 'verified'])->name('homepage');


Route::get('/adventure-quest', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::get('/book-drive', function () {
    return Inertia::render('BookDrive');
})->middleware(['auth', 'verified'])->name('book-drive');

Route::get('/upload-form', function () {
    return Inertia::render('UploadForm');
})->middleware(['auth', 'verified'])->name('new-upload');


Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});




require __DIR__.'/auth.php';
