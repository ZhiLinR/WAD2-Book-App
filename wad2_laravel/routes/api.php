<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DonationsController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

//PUBLIC APIs------------------------------------------------------------------------------
Route::get('get-donations', [DonationsController::class, 'query'])
    ->name('donations.fetch');

//USER RESTRICTED APIs-------------------------------------------------------------------------
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware(['auth', 'auth.session'])->group(function () {
    //Get Donations by User
    Route::get('user/donations', [DonationsController::class, 'getDonationsByUser'])->name('donations.fetchByUser');
    //Post A New Donation
    Route::post('user/donations', [DonationsController::class, 'postDonationByUser'])->name('donations.postByUser');
    //Post A New Donation
    Route::post('location/get-Location', [LocationController::class, 'getLocation'])->name('location.fetchByUser');
});




//HELPERS--------------------------------------------------------------------------------------
//Get Distinct Categories
Route::middleware(['auth', 'auth.session'])->group(function () {
    Route::get('helpers/categories', [DonationsController::class, 'getCategories'])->name('donations.getCategories');
    Route::get('helpers/authors', [DonationsController::class, 'getAuthors'])->name('donations.getAuthors');
});
