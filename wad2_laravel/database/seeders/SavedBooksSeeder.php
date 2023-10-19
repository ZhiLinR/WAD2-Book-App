<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SavedBooksSeeder extends Seeder
{
    /**
     * Run the database seeds.
     * user_saved_books
     * pref_id, gcc_bk_id, local_bk_id, fk_user_id
     */
    
    public function run(): void
    {
        DB::table('user_saved_books')->insert([
            'fk_user_id' => 'jasper@email.com',
            'local_bk_id' => 2,
        ]);
        DB::table('user_saved_books')->insert([
            'fk_user_id' => 'henry@email.com',
            'local_bk_id' => 2,
        ]);
        DB::table('user_saved_books')->insert([
            'fk_user_id' => 'thuya@email.com',
            'local_bk_id' => 1,
        ]);
        DB::table('user_saved_books')->insert([
            'fk_user_id' => 'jasper@email.com',
            'local_bk_id' => 3,
        ]);
    }
}
