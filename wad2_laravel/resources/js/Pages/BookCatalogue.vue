<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head } from '@inertiajs/vue3';
import { Scene, SceneItem } from "scenejs";
import { typing } from "@scenejs/effects";
import { onBeforeMount } from 'vue';
</script>

<script>
//henry edit to make book readable
import { loadGoogleBooks } from '../bookreader';
//henry edit to make book readable

export default {
    data() {
        return {
            // searchby: 'Title',
            input: '',
            input2: '',
            freeOnly: false,
            books: [],
            categories: [],
            authors: [],
        }
    },

    //henry edit to make book readable
    mounted(){
        loadGoogleBooks(() => {
            google.books.load();
        });
        
    },
    //henry edit to make book readable

    methods: {
        getCategories() {
            return axios.get("/api/helpers/categories")
                .then(
                    response => {
                        /* console.log(typeof response.data);
                        console.log(response.data); */
                        this.categories = response.data;
                    }
                )
        },
        getAuthors() {
            return axios.get("/api/helpers/authors")
                .then(
                    response => {
                        this.authors = response.data;
                        return response.data;
                    }
                )
        },
        changeTyping:  function (typingArray) {
            function _makeScene(textRen){
                let scene = new Scene({
                    ".container span": typing({
                        text: textRen,
                        duration: 7,
                    }),
                    ".cursor": {
                        0: { opacity: 0 },
                        0.5: { opacity: 0 },
                        "0.5>": { opacity: 1 },
                        1: { opacity: 1 },
                        options: {
                            iterationCount: 8,
                        }
                    },
                }, {
                    iterationCount: 2,
                    direction: "alternate",
                    selector: true,
                    playSpeed: 4
                })
                scene.play().on("ended", () => {
                    return true;
                });
            }
            setInterval(function () {
                let index = Math.floor(Math.random() * 3)
                _makeScene(typingArray[index].category)
            }, 3000);
        },
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
    mounted: async function () {
        await this.getCategories();
        await this.getAuthors();

        console.log(this.categories.length)
        this.changeTyping(this.categories)
    },
}
</script>

<template>
    <AuthenticatedLayout>
        <div class="container-fluid">
            <div class="row">
                <div class="col">
                    <div class="text-center">
                        <h1 class="mx-auto">Venture into the realm of </h1>
                        <div class="container">
                            <span></span>
                            <div class="cursor"></div>
                        </div>
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

<style>
.container span {
    font-size: 2rem !important;
}

.cursor {
    display: inline-block;
    width: 2px;
    height: 25px;
    background: #333;
}

h1,
span {
    -webkit-text-stroke: 0.3px #4B4B4B;
    color: #FFF !important;
    text-shadow: 2px 2px 2.5px rgba(0, 0, 0, 0.80);
    font-family: Patrick Hand SC;
}
</style>
