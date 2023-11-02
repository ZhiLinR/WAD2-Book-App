<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DonationsController;
use App\Http\Controllers\SkilltreeController;
use App\Http\Controllers\LocationController;

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
    // GET DATABASE BY USER_PREF
    Route::get('skilltree/get-object', [SkilltreeController::class,'getDatabaseObj'])->name('database.fetchByUser');
    // UPDATE FANATASY DATA
    Route::post('skilltree/update-fantasy-object', [SkilltreeController::class,'updateFantasyObj'])->name('fantasy.UpdateUser');
    // UPDATE HORROR DATA
    Route::post('skilltree/update-horror-object', [SkilltreeController::class,'updateHorrorObj'])->name('horror.UpdateUser');
    // UPDATE HORROR DATA
    Route::post('skilltree/update-mystery-object', [SkilltreeController::class,'updateMysteryObj'])->name('mystery.UpdateUser');
    // UPDATE HORROR DATA
    Route::post('skilltree/update-romance-object', [SkilltreeController::class,'updateRomanceObj'])->name('romance.UpdateUser');
    // UPDATE HORROR DATA
    Route::post('skilltree/update-nonfiction-object', [SkilltreeController::class,'updateNonfictionObj'])->name('nonfiction.UpdateUser');
    
    // GET READ DATA
    Route::post('skilltree/get-read-object', [SkilltreeController::class,'getReadObj'])->name('read.fetchByUser');
    // UPdate READ DATA
    Route::post('skilltree/update-read-object', [SkilltreeController::class,'updateReadObj'])->name('read.updateByUser');
    //Get the location   
    Route::post('location/get-Location', [LocationController::class, 'getLocation'])->name('location.fetchByUser');
});




//HELPERS--------------------------------------------------------------------------------------
//Get Distinct Categories
Route::middleware(['auth', 'auth.session'])->group(function () {
    Route::get('helpers/categories', [DonationsController::class, 'getCategories'])->name('donations.getCategories');
    Route::get('helpers/authors', [DonationsController::class, 'getAuthors'])->name('donations.getAuthors');
});
