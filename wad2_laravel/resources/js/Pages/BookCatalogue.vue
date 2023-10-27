<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head } from '@inertiajs/vue3';
</script>

<script>
export default {
    data() {
        return {
            // searchby: 'Title',
            input: '',
            input2: '',
            freeOnly: false,
            books: [],
        }
    },
    methods: {
        getBooks() {
            const url = 'https://www.googleapis.com/books/v1/volumes';
            const searchTermTitle = this.input;
            const searchTermAuthor = this.input2;
            let query = '';
            // const searchParam = this.searchby === 'Title' ? 'intitle' : 'inauthor';

            //user knows title and author
            if (this.input != '' && this.input2 != '') {
                query = `intitle:${searchTermTitle} inauthor:${searchTermAuthor}`;
            }
            //user knows title but NOT author
            else if (this.input != '' && this.input2 == '') {
                query = `intitle:${searchTermTitle}`;
            }
            // user knows author but NOT title
            else if (this.input == '' && this.input2 != '') {
                query = `inauthor:${searchTermAuthor}`;
            }


            const params = {
                q: query,
                filter: this.freeOnly ? 'free-ebooks' : undefined,
                maxResults: 20
            };

            axios.get(url, {
                params
            })
                .then(response => {
                    if (response.data.items) {
                        this.books = response.data.items.map(item => {
                            const volumeInfo = item.volumeInfo;
                            console.log(item)
                            return {
                                id: item.id,
                                title: volumeInfo.title,
                                author: volumeInfo.authors ? volumeInfo.authors.join(', ') : 'Unknown',
                                isbn: volumeInfo.industryIdentifiers ? volumeInfo.industryIdentifiers[0].identifier : 'Unknown',
                                publishedYear: volumeInfo.publishedDate,
                                coverImage: volumeInfo.imageLinks ? volumeInfo.imageLinks.thumbnail : 'No Image',
                                category: volumeInfo.categories ? volumeInfo.categories[0] : 'Unidentified',
                                embedded: item.accessInfo.embeddable ? item.accessInfo.embeddable : false,

                            };
                        });
                    }
                    else {
                        alert('Oops! Unable to find book!')
                    }

                })

                .catch(error => {
                    console.error(error);
                });
        },

        alertNotFound() {
            alert("could not embed the book!");
        },

        readBook(volumeId) {
            var viewer = new google.books.DefaultViewer(document.getElementById('viewerCanvas'));
            viewer.load(volumeId, this.alertNotFound);
            console.log(viewer)
            console.log(volumeId)
        },

    },


}


</script>

<template>
    <Head title="Book Catalogue" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">Catalogue</h2>
        </template>
        <div class="container-fluid bg-white">
            <div class="row">
                <div class="col">
                    <div class="text-center">
                        <h1 class="mx-auto">Book Catalogue</h1>
                        <div>
                            <input type="text" class="form-control w-50 mx-auto m-2" v-model="input"
                                placeholder="Book Title">
                        </div>

                        <div>
                            <input type="text" class="form-control w-50 mx-auto m-2" v-model="input2" placeholder="Author">
                        </div>

                        <div class="m-3">Free Books Only
                            <input type="checkbox" v-model="freeOnly">
                        </div>

                        <button type="submit" class="btn btn-primary m-2" @click="getBooks">Search</button>

                        <h3>Results for "{{ input }}" by "{{ input2 }}"</h3>

                        <div>
                            <img src="" alt="">
                        </div>
                    </div>
                </div>
            </div>


            <div class="row">

                <div class="col-lg-4 order-lg-first">

                    <div v-for="book in books" :key="book.id">
                        <div class="row">
                            <div class="col">
                                <div class="card img-fluid">

                                    <img :src="book.coverImage" alt="IMAGE NOT AVAILABLE" width="100">
                                    <div class="card-body">
                                        <h5 class="card-title">{{ book.title }}</h5>

                                        <div v-if="book.embedded">
                                            <button v-on:click="readBook(book.id)" class="btn btn-outline-danger my-2">Read
                                                Here</button>
                                        </div>

                                        <p class="card-text">Author: {{ book.author }}</p>
                                        <p class="card-text">Genre: {{ book.category }}</p>
                                        <p class="card-text">ISBN: {{ book.isbn }}</p>
                                        <p class="card-text">ID: {{ book.id }}</p>
                                        <p class="card-text">Published Year: {{ book.publishedYear }}</p>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-lg-8 order-md-first">
                    <div id="viewerCanvas" style="width: 100%; height: 100%"></div>
                </div>

            </div>

        </div>

    </AuthenticatedLayout>
</template>

