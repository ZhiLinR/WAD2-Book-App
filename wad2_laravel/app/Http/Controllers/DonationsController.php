<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Providers\RouteServiceProvider;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use Inertia\Response;

class DonationsController extends Controller
{
    public function query()
    {
        $books = DB::table('book_donations')->get();
        return $books;
    }

    public function getDonationsByUser(Request $request)
    {
        //print($request->user());
        $donations = DB::table('book_donations')->get()->where("fk_user_donor", $request->user()->email);
        return $donations;
    }

    public function postDonationByUser(Request $request)
    {
        DB::table('book_donations')->insert([
            'fk_user_donor'=> $request->user()->email,
            'bk_name'=>$request->bookName,
            'author' => $request->author,
            'category' => $request->category,
            'description' => $request->description,
        ]);
        //print($request->author);
        return response('Posted Successfully', 200);
    }

    public function getCategories(Request $request)
    {
        //$categories = DB::table('book_donations')->distinct()->select('category')->get();
        return ["Fantasy","Mystery","Non-Fiction","Horror","Romance"];
    }

    public function getAuthors(Request $request)
    {
        $authors = DB::table('book_donations')->distinct()->select('author')->get();
        return $authors;
    }
}
