<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([
            'name' => 'jasper',
            'email' => 'jasper@email.com',
            'password' => bcrypt('password'),
        ]);
        DB::table('users')->insert([
            'name' => 'henry',
            'email' => 'henry@email.com',
            'password' => bcrypt('123'),
        ]);
        DB::table('users')->insert([
            'name' => 'thuya',
            'email' => 'thuya@email.com',
            'password' => bcrypt('456'),
        ]);
    }
}
