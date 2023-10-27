<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;

class DonationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     * Table Name: book_donations
     * fk_user_donor, 
     * bk_name, 
     * category, 
     * author, 
     * location, 
     * description, 
     */
    public function run(): void
    {
        DB::table('book_donations')->insert([
            'fk_user_donor' => 'jasper@email.com',
            'bk_name' => "Lord of the Rings",
            'category' => "Fantasy",
            'author' => "J. R. R. Tolkien.",
            'location' => "8VGQ+MX Singapore",
            'description' => "Giving away an old Lord of the Rings book. Condition 8/10",
        ]);
        DB::table('book_donations')->insert([
            'fk_user_donor' => 'henry@email.com',
            'bk_name' => "Influence: The Psychology of Persuasion",
            'category' => "Business",
            'author' => "Robert Cialdini",
            'location' => "7VWV+WR Singapore",
            'description' => "Don't need it anymore. ",
        ]);
        DB::table('book_donations')->insert([
            'fk_user_donor' => 'thuya@email.com',
            'bk_name' => "Impro: Improvisation and the Theatre",
            'category' => "Art and Creativity",
            'author' => "Keith Johnstone",
            'location' => "8W24+G3 Singapore",
            'description' => "Great book! Condition 7/10, read a few times but clearing up space in my house",
        ]);
    }
}
