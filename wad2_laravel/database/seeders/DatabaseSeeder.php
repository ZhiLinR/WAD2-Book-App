<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run()
    {
        $this->call(UsersTableSeeder::class);
        $this->call(DonationSeeder::class);
        $this->call(PreferenceSeeder::class);
        $this->call(SavedBooksSeeder::class);
        // \App\Models\User::factory(10)->create();
    }
}
