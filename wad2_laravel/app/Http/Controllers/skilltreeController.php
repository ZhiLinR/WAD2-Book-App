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

class SkilltreeController extends Controller
{
    public function getDatabaseObj(Request $request)
    {
        $books = DB::table('user_pref')->get()->where("username", $request->user()->email);
        return $books;
    }
    public function updateFantasyObj(Request $request){
        $book = $request->input('book');

        $affected = DB::table("user_pref")
        ->where("username", $request->user()->email)
        ->update(["fantasy_data"=>$book]);

        return $affected;
    }

    public function updateMysteryObj(Request $request){
        $book = $request->input('book');

        $affected = DB::table("user_pref")
        ->where("username", $request->user()->email)
        ->update(["mystery_data"=>$book]);
        
        return $affected;
    }
    public function updateRomanceObj(Request $request){
        $book = $request->input('book');

        $affected = DB::table("user_pref")
        ->where("username", $request->user()->email)
        ->update(["romance_data"=>$book]);
        
        return $affected;
    }
    public function updateNonfictionObj(Request $request){
        $book = $request->input('book');

        $affected = DB::table("user_pref")
        ->where("username", $request->user()->email)
        ->update(["nonfiction_data"=>$book]);
        
        return $affected;
    }
    public function updateHorrorObj(Request $request){
        $book = $request->input('book');

        $affected = DB::table("user_pref")
        ->where("username", $request->user()->email)
        ->update(["horror_data"=>$book]);
        
        return $affected;
    }

    public function getReadObj(request $request){
        $genre = $request->input("genre");
        $books = DB::table('user_pref')->where("username", $request->user()->email)->pluck($genre);
        return $books;
    }

    public function updateReadObj(request $request){
        $genre = $request->input("genre");
        $book_sql = $request->input("book");

        $affected = DB::table("user_pref")
        ->where("username", $request->user()->email)
        ->update([$genre=>$book_sql]);

        return $affected;
    }
    
    
}
