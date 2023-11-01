<?php
class LocationController extends Controller
{
    public function getLocation()
    {
        $location = DB::table('book_donations')->get();
        return $location;
    }}
    ?>


