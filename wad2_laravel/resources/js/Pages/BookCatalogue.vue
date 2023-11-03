<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Card from '@/Components/Card.vue';
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
    mounted() {
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
        changeTyping: function (typingArray) {
            //console.log(typingArray.length)
            function _makeScene(textRen) {
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
                let index = Math.floor(Math.random() * (typingArray.length - 1))
                if (("category" in typingArray[index]) && typingArray[index].category != null) {
                    _makeScene(typingArray[index].category)
                } else if (("author" in typingArray[index]) && typingArray[index].author != null) {
                    _makeScene(typingArray[index].author)
                }
            }, 5000);
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
                            //console.log(item)
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
            //console.log(viewer)
            //console.log(volumeId)
        },
        scrollToElement() {
            const [el] = this.$refs.last;
            if (el) {
                el.scrollIntoView({ behavior: "smooth" });
            }

        },
        mounted: async function () {
            await this.getCategories();
            await this.getAuthors();

            //console.log(this.categories.length)
            this.changeTyping(this.categories.concat(this.authors))
        },
    }
}
</script>

<template>
    <AuthenticatedLayout>

        <div class="container-fluid position-absolute top-50 start-50 translate-middle" height="100%">

            <div class="text-center">
                <h1 class="mx-auto">Venture into the realm of </h1>
                <div class="container">
                    <span></span>
                    <div class="cursor"></div>
                </div>
                <div class="container">
                    <div class="row g-2 m-4 d-flex justify-content-center align-items-center">
                        <div class="col-sm-12 col-lg-3">
                            <input @keyup.enter="getBooks" type="text" class="form-control" v-model="input"
                                placeholder="Book Title">
                        </div>
                        <div class="col-sm-12 col-lg-3">
                            <input @keyup.enter="getBooks" type="text" class="form-control" v-model="input2"
                                placeholder="Author">
                        </div>
                    </div>
                    <div class="row g-2 m-2 d-flex justify-content-center">
                        <div class="col-sm-6 col-lg-2">
                            <p id="checkbox_text">Free Books Only <input type="checkbox" class="form-check-input mx-4"
                                    v-model="freeOnly"> </p>

                        </div>
                        <div class="col-sm-6 col-lg-1" hidden>
                            <button type="submit" id="btn_search" class="btn btn-primary" @click="getBooks">Search</button>
                        </div>
                    </div>
                </div>


                <!-- <h3>Results for "{{ input }}" by "{{ input2 }}"</h3> -->
            </div>

        </div>
        <div ref="last" class="container row d-flex justify-content-evenly g-2" height="100%" hidden>

            <Card :imgSrc="book.coverImage" v-for="book in books" :key="book.id">
                <template v-slot:cardTitle>{{ book.title }}</template>
                <template v-slot:cardText>
                    <p class="card-text">
                        Author: {{ book.author }} <br>
                        Genre: {{ book.category }} <br>
                        Published Year: {{ book.publishedYear }} <br>
                    </p>

                    <p hidden>ID: {{ book.id }}</p>
                    <p class="card-text fw-light"><small>ISBN: {{ book.isbn }}</small></p>
                </template>
                <template v-slot:btnRead>
                    <div v-if="book.embedded">
                        <button v-on:click="readBook(book.id)" class="btn btn-primary">Read</button>
                    </div>
                </template>
            </Card>
            <div class="col-lg-8 order-md-first">
                <div id="viewerCanvas" style="width: 100%; height: 100%"></div>
            </div>

        </div>


       <!--  <button @click="scrollToElement">scroll to last</button> -->

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
span,
#checkbox_text {
    -webkit-text-stroke: 0.3px #4B4B4B;
    color: #FFF !important;
    text-shadow: 2px 2px 2.5px rgba(0, 0, 0, 0.80);
    font-family: Patrick Hand SC;
}

#btn_search {
    --bs-btn-border-radius: 10rem !important;
    -webkit-text-stroke: 0.01rem #242424;
    color: white;
    background-color: rgba(255, 255, 255, 0.5);
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.45);
    box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25) !important;
    padding: 5px 30px;
}
</style>
