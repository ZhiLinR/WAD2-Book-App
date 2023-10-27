<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PreferenceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     * Table: user_pref
     * Compulsory fields: fk_user_id, pref
     */
    public function run(): void
    {
        DB::table('user_pref')->insert([
            'fk_user_id' => 'jasper@email.com',
            'pref' => "Fantasy",
        ]);
        DB::table('user_pref')->insert([
            'fk_user_id' => 'jasper@email.com',
            'pref' => "Business",
        ]);
        DB::table('user_pref')->insert([
            'fk_user_id' => 'thuya@email.com',
            'pref' => "Fantasy",
        ]);
        DB::table('user_pref')->insert([
            'fk_user_id' => 'thuya@email.com',
            'pref' => "Art",
        ]);
        DB::table('user_pref')->insert([
            'fk_user_id' => 'henry@email.com',
            'pref' => "Technology",
        ]);
        DB::table('user_pref')->insert([
            'fk_user_id' => 'henry@email.com',
            'pref' => "Fiction",
        ]);
    }
}
