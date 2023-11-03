<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head } from '@inertiajs/vue3';
import { left } from '@popperjs/core';
import axios from 'axios';
import.meta.env.BASE_URL

</script>
<script>


export default {
    data() {
        return {
            result: null, // Initialize result as null
            data: this.getdatabaseobj(),
            fantasy: null,
            mystery: null,
            romance: null,
            horror: null,
            nonfiction: null,
            publicPath: import.meta.env.BASE_URL,
            books: [],
            read: this.getReadObj("fantasy_read"),
            fantasy_read:null,
            mystery_read:null,
            horror_read:null,
            romance_read:null,
            nonfiction_read:null
        }
    },
    mounted() {


        Promise.all([this.data,this.read]).then(result => {
            this.fantasy = JSON.parse(result[0].fantasy_data)
            this.mystery = JSON.parse(result[0].mystery_data)
            this.romance = JSON.parse(result[0].romance_data)
            this.horror = JSON.parse(result[0].horror_data)
            this.nonfiction = JSON.parse(result[0].nonfiction_data)
            var fantasy_tree = this.createTree(this.fantasy, 'fantasy');
            var mystery_tree = this.createTree(this.mystery, "mystery")
            var romance_tree = this.createTree(this.romance, "romance")
            var horror_tree = this.createTree(this.horror, "horror")
            var nonfiction_tree = this.createTree(this.nonfiction, "nonfiction")
            var combine = fantasy_tree + mystery_tree + romance_tree + horror_tree + nonfiction_tree
            this.result = combine;
            this.getImg()
            this.fantasy_read = JSON.parse(result[0].fantasy_read)
            this.mystery_read = JSON.parse(result[0].mystery_read)
            this.horror_read = JSON.parse(result[0].horror_read)
            this.romance_read = JSON.parse(result[0].romance_read)
            this.nonfiction_read = JSON.parse(result[0].nonfiction_read)
            

            // console.log(this.read)
            // this.fantasy_read = JSON.parse(result[1].fantasy_read)
            // this.mystery_read = JSON.parse(result[1].mystery_read)
            // this.horror_read = JSON.parse(result[1].horror_read)
            // this.romance_read = JSON.parse(result[1].romance_read)
            // this.nonfiction_read = JSON.parse(result[1].nonfiction_read)



        })



    },
    methods: {


        createTree(item, id) {
            const { left, right, head } = item
            var number = Math.floor(Math.random() * (12 - 1 + 1)) + 1
            var add = id + number
            var final = `<li>
        <a href="javascript:void(0)" id="click"><img src= '/${id}/gif/${add}.gif' class=${id}width ='20px' height ='20px'" id ="click">
        <br><span width='20px' id="click" class =${id}>${head}</span></a>`

            if (left || right) {
                final += `<ul>`
                if (left) {
                    final += this.createTree(left, id)
                }
                if (right) {
                    final += this.createTree(right, id)
                }
                final += `</ul>`
            }
            final += `</li>`
            return final

        },
        getImg() {
            var main = document.getElementById("item")
            var img = main.getElementsByTagName("img")
            var number = Math.floor(Math.random() * (12 - 1 + 1)) + 1

            for (var i = 0; i < img.length; i++) {

                var identifier = img.className
                var rando = identifier + number

                img[i].src = "/" + identifier + "/gif/" + rando + ".gif"


            }
        },

        async addItem(item, identifier) {

            let data, url;
            item = item.toLowerCase()

            switch (identifier) {
                case "fantasy":
                    data = await this.fantasy;
                    url = "/api/skilltree/update-fantasy-object";
                    break;
                case "mystery":
                    data = await this.mystery;
                    url = "/api/skilltree/update-mystery-object";
                    break;
                case "romance":
                    data = await this.romance;
                    url = "/api/skilltree/update-romance-object";
                    break;
                case "nonfiction":
                    data = await this.nonfiction;
                    url = "/api/skilltree/update-nonfiction-object";
                    break;
                case "horror":
                    data = await this.horror;
                    url = "/api/skilltree/update-horror-object";
                    break;
                default:
                    console.log("Invalid identifier");
                    return;
            }

            var node = this.bfs(data, item);
        
            console.log(node)
            if (node != false) {




                const newurl = 'https://www.googleapis.com/books/v1/volumes';
            const searchTermSubject = identifier; //e.g fantasy

            var thuyaArr = []

            var query = `subject:${searchTermSubject}`

            const params = {
                q: query,
                maxResults: 40
            }

            axios.get(newurl, {
                params
            })

                .then(response => {
                    var forty_data = response.data.items
                    for (var arr of forty_data) {
                        let rating = arr.volumeInfo.averageRating
                        let word_count = arr.volumeInfo.title.length
                        if (rating >= 4.0&& word_count<=25) {
                            thuyaArr.push(arr)
                        }
                    }

                    // var recommendation=""
                    // while(recommendation in )

                    let randomIndex = Math.floor(Math.random() * thuyaArr.length);

                    let recommendation = thuyaArr[randomIndex]
                    var book_name =recommendation.volumeInfo.title
                    node.left = { head: book_name };
                node.right = { head: "Own reco" };
                var sql = JSON.stringify(data);
                this.sendData(url, sql);
                this.updateReadList(identifier,item)
                location.reload()
                
                })
            }
            else {
                alert("Please select another node")
            }
        },
        addingBook() {

            var title = document.getElementById("cardtitle")
            var identifier = title.className
            if (identifier.search("fantasy") != -1) {


                this.addItem(title.innerHTML, "fantasy")
            }
            else if (identifier.search("horror") != -1) {


                this.addItem(title.innerHTML, "horror")
            }
            else if (identifier.search("nonfiction") != -1) {

                this.addItem(title.innerHTML, "nonfiction")
            }
            else if (identifier.search("romance") != -1) {


                this.addItem(title.innerHTML, "romance")
            }
            else if (identifier.search("mystery") != -1) {


                this.addItem(title.innerHTML, "mystery")
            }



        },




        getdatabaseobj() {
            var url = "/api/skilltree/get-object";

            return axios.get(url)
                .then(result => {
                    return result.data[0];
                })
                .catch(err => {
                    console.log('Error: ' + err);
                    throw err;
                });
        },


        bfs(obj, find) {
            var counter = 0
            var queue = [obj]
            while (queue.length > 0) {
                

                var check = queue.shift()
                console.log(check)
                var headChecker = check.head.replace("'", "")
                var findChecker = find.replace("'", "")
                var headChecker= headChecker.replace("-"," ")
                var findChecker= findChecker.replace("-"," ")

                console.log(headChecker)
                console.log(findChecker)
                
                if (headChecker.toLowerCase() == findChecker.toLowerCase()) {
                    counter ++
                    console.log(counter)
                    if (find == "Own Reco") {
                        alert("This is an empty node")
                    }
                    else if (check.hasOwnProperty("left") || check.hasOwnProperty("right")) {
                        alert("Please select another node 1211")

                    }
                    else {
                        return check
                    }
                }
                else {
                    if (check.hasOwnProperty("left")) {
                        queue.push(check.left)
                    }
                    if (check.hasOwnProperty("right")) {
                        queue.push(check.right)
                    }
                }
            }
            return false
        },

        sendData(url, data) {
            axios.post(url, {
                book: data
            })
                .then(response => { })
                .catch(error => {

                })
        },
        /* Set the width of the side navigation to 0 */
        closeNav() {
            document.getElementById("mySidenav").style.width = "0"
        }
        ,
        closeNav1() {
            document.getElementById("mySidenav1").style.width = "0"
        }
        ,



        openNav(event) {
            if (event.target.id == "click") {

                if (event.target.localName == "a" || event.target.localName == "img") {
                    var span = event.target.parentNode.getElementsByTagName("span")[0]
                    var genre = span.className
                    var book = span.innerHTML

                }

                else {
                    var genre = event.target.className
                    var book = event.target.innerHTML

                }
            }
            if ((book === "Own reco" || event.target.localName == "li" || event.target.localName == "ul")) {

                this.closeNav()
            }
            else if (book == "fantasy" || book == "mystery" || book == "romance" || book == "nonfiction" || book == "horror") {
                var url = "/api/skilltree/get-read-object"
                book = book.toLowerCase()
                var book_read = book + "_read"

                axios.post(url, {
                    genre: book_read
                })
                    .then(response => {
                        var read = response.data
                        var list = JSON.parse(read)

                        var count = 0
                        for (var i = 0; i < list.length; i++) {
                            count += 1
                        }
                        var sidenav = document.getElementById("mySidenav")
                        sidenav.style.width = "300px"
                        var thumbnail = document.getElementById("thumbnail")
                        var title = document.getElementById("cardtitle")
                        var desc = document.getElementById("carddesc")
                        var button = document.getElementById("completed")
                        var left = 5 - count
                        if (left < 0) {
                            left = "completed"
                        }
                        button.style.display = "none"
                        title.innerHTML = `${book}`
                        desc.innerHTML = `Number of ${book} read: ${count}<br> Number of books till Animations: ${left}`
                        thumbnail.src = `/main/${book}.jpeg`
                    })
                    .catch(error => {

                    })


            }
            else {
                var sidenav = document.getElementById("mySidenav")
                sidenav.style.width = "300px"
                const url = 'https://www.googleapis.com/books/v1/volumes'
                var query = `intitle:${book}`
                const params = {
                    q: query,
                    maxResults: 20
                };
                axios.get(url, {
                    params
                })
                    .then(response => {
                        var img = response.data.items[0].volumeInfo.imageLinks.thumbnail
                        var cardtitle = response.data.items[0].volumeInfo.title
                        var carddesc = response.data.items[0].volumeInfo.description
                        var thumbnail = document.getElementById("thumbnail")
                        thumbnail.src = img
                        var title = document.getElementById("cardtitle")
                        var desc = document.getElementById("carddesc")
                        title.className = "card-title " + genre
                        title.innerHTML = cardtitle
                        desc.innerHTML = carddesc
                        var button = document.getElementById("completed")
                        button.style.display = ""

                    })

                    .catch(error => {
                        console.error(error);
                    });
            }
        },
        getBooks() {
            var genre = document.getElementById("genre")
            const url = 'https://www.googleapis.com/books/v1/volumes';
            const searchTermTitle = document.getElementById("bookname").value
            const searchTermAuthor = document.getElementById("author").value
            if(genre.value==""||(searchTermTitle==""&&searchTermAuthor=="")){
                alert("Please fill in genre and at least title/author")
                return""
            }
            else if(genre.value=="fantasy"||genre.value=="mystery"||genre.value=="horror"||genre.value=="romance"||genre.value=="nonfiction") {
            var sidenav = document.getElementById("mySidenav1")
            var closenav = document.getElementById("mySidenav")
            closenav.style.width="0px"
            sidenav.style.width = "300px"
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
                maxResults: 10
            };

            axios.get(url, {
                params
            })
                .then(response => {
                    console.log(response)
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
        }else {
                console.log(genre.value)
                alert("Please only key in fantasy,mystery,horror or romance")
            }
    
    
    },








        bfsAndUpdate(node, target, replacement) {
            const queue = [node];

            while (queue.length > 0) {
                const currentNode = queue.shift();

                if (currentNode.head === target) {
                    // Update the node when found
                    currentNode.head = replacement.head;
                    currentNode.left = replacement.left;
                    currentNode.right = replacement.right;
                    return;
                }

                if (currentNode.left) {
                    queue.push(currentNode.left);
                }
                if (currentNode.right) {
                    queue.push(currentNode.right);
                }
            }
        }
        
        ,
        addOwnReco(genre, title) {
            if (genre == "fantasy") {
                var tree = this.fantasy
            }
            else if (genre == "mystery") {
                var tree = this.mystery
            }
            else if (genre == "horror") {
                var tree = this.horror
            }
            else if (genre == "romance") {
                var tree = this.romance
            }
            else if (genre == "nonfiction") {
                var tree = this.nonfiction
            }

            const url = 'https://www.googleapis.com/books/v1/volumes';
            const searchTermSubject = genre; //e.g fantasy

            var thuyaArr = []

            var query = `subject:${searchTermSubject}`
            var check_if_exist = false

            const params = {
                q: query,
                maxResults: 40
            }

            axios.get(url, {
                params
            })

                .then(response => {
                    var data = response.data.items
                    for (var arr of data) {
                        let rating = arr.volumeInfo.averageRating   
                        let word_count = arr.volumeInfo.title.length
                        if ( rating >= 4.0&& word_count<=25) {
                            thuyaArr.push(arr)
                        }
                    }

                    console.log(thuyaArr)

                    let randomIndex = Math.floor(Math.random() * thuyaArr.length);

                    let recommendation = thuyaArr[randomIndex]
                    var book_name =recommendation.volumeInfo.title
                    book_name = book_name.toLowerCase()
                    var target = "Own reco"
                const replacement = {
                head: title.toLowerCase(),
                left: { head: book_name},
                right: { head: "Own reco" }
            };

            this.bfsAndUpdate(tree, target, replacement)
            const updated = JSON.stringify(tree)
            var url = `/api/skilltree/update-${genre}-object`
            this.sendData(url, updated)
            location.reload()
                })


        }
        ,

        

        manualAdd(event){
            var title = event.target.parentNode.parentNode.getElementsByTagName("h5")[0].innerText
            var genre = document.getElementById("genre").value
            this.updateReadList(genre,title)
            
            
        },

        updateReadList(genre1, title) {
            var url = "/api/skilltree/get-read-object"
            var title = title.toLowerCase()
            var genre = genre1.toLowerCase()
            var book_read = genre + "_read"
            axios.post(url, {
                genre: book_read
            })
                .then((result) => {
                    var read = result.data
                    console.log("test")
                    var list = JSON.parse(read)
                    var url = "/api/skilltree/update-read-object"
                    list.push(title)
                    list = JSON.stringify(list)
                   
                    axios.post(url, {
                        genre: book_read,
                        book: list
                    })
                        .then(response => {
                            this.addOwnReco(genre,title)
                        })
                        .catch(error => {
                            console.log(error)
                        })

                }).catch((err) => {

                });







        },

        getReadObj(genre){
            var url = "/api/skilltree/get-read-object"
            return axios.post(url, {
                genre: genre
            })
                .then((result) => {
                    return result.data[0]
                })
        },
        check(){
            console.log(this.fantasy_read)
            console.log(this.mystery_read)
            console.log(this.horror_read)
            console.log(this.nonfiction_read)
            console.log(this.romance_read)
        }






    }

}


// var addtree = document.getElementById("item")
    
//     var mid =""
//     Promise.all([getfantasyobj(), gethorrorobj(), getromanceobj(), getmysteryobj(), getnonfictionobj()])
//     .then(results => {
//         for(i=0;i<results.length;i++){
//             var id = results[i].head
//             mid+=createTree(results[i],id)
//         }
//         addtree.innerHTML =mid
//         console.log(addtree)
        
//     })
//     .catch(error => {
//         console.log('Error: ' + error);
//     });

    
    
//    Promise.all([getfantasyobj()])
//    .then((result) => {
//     console.log(result)
//    }).catch((err) => {
    
//    });
  
</script>
<template>
    <Head title="Book Catalogue" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">Catalogue</h2>
        </template>
        <div id="mySidenav" class="sidenav">
            <a href="javascript:void(0)" class="closebtn" @click="closeNav">&times;</a>
            <div class="container" style="display: flex; justify-content: center;">
                <!-- card -->
                <div class="card" id="card" style="max-width: 18rem;">
                    <img id ='thumbnail' class="card-img-top" alt="Card image cap" max-width="300px" >
                    <div class="card-body">
                      <h5 class="card-title" id ="cardtitle"></h5>
                      <p class="card-text" id = "carddesc">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                      <a href="#" class="btn btn-primary" @click="addingBook" id="completed"><span style="text-align: center;">I have COMPLETED IT!</span></a>
                    </div>
                  </div>

                </div>

            
            

            
          </div>
          <div id="mySidenav1" class="sidenav">
            <a href="javascript:void(0)" class="closebtn" @click="closeNav1">&times;</a>
            <div class="container" style="display: flex; justify-content: center;">
                <div class="card" id="card" style="max-width: 18rem;">

        <div v-for="book in books" :key="book.id">
        <div class="row">
            <div class="col">
                <div class="card img-fluid" width="300">

                    <img :src="book.coverImage" alt="IMAGE NOT AVAILABLE" width="250">
                    <div class="card-body">
                        <h5 class="card-title">{{ book.title }}</h5>
                        <p class="card-text">Author: {{ book.author }}</p>
                        <p class="card-text">Genre: {{ book.category }}</p>
                        <p class="card-text">ISBN: {{ book.isbn }}</p>
                        <p class="card-text">ID: {{ book.id }}</p>
                        <p class="card-text">Published Year: {{ book.publishedYear }}</p>
                        <p><button type="button" class="btn btn-dark" @click="manualAdd">I have Read!</button></p>
                    </div>
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
            
            

            



    <div id="main">
    <div class="container-fluid">
        <div class="row">
            <div class="tree col-md-5 col-sm-2">
                <ul style="padding-left: 0px;">
                    <li> <a href="javascript:void(0)">
                            <br><span>Books</span></a>
                        <ul id="item" v-html="result" v-on:click="openNav">
                        
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>`
</div>
<div class="container-fluid text-center">
    <input type="text" class="form-control w-50 mx-auto m-2"  placeholder="Book Name" id="bookname">
    <input type="text" class="form-control w-50 mx-auto m-2"  placeholder="Author" id="author">
    <input type="text" class="form-control w-50 mx-auto m-2"  placeholder="Please key in either fantasy,mystery,romance,horror,nonfiction" id="genre">
    <button type="button" class="btn btn-primary m-2" @click="getBooks">Search</button>
    <button type="button" class="btn btn-primary m-2" @click="check">tester</button>
    
        <!-- <input id ="bookname" type="text" class="form-control col-3" placeholder="Book Name" aria-label="Recipient's username" aria-describedby="basic-addon2">
        <input id ="author" type="text" class="form-control col-3" placeholder="Author" aria-label="Recipient's username" aria-describedby="basic-addon2">
        <input id ="genre" type="text" class="form-control col-3" placeholder="Please key in either fantasy,mystery,romance,horror,nonfiction" aria-label="Recipient's username" aria-describedby="basic-addon2"> -->


</div>



    </AuthenticatedLayout>
</template>

<style>



* {
	padding: 0px;
	margin: 0px;
	box-sizing: border-box;
}
body {
	height: 100vh;
	display: grid;
	align-items: center;
	
}
.tree {
	width: 100%;
	height: auto;
	text-align: center;
}
.tree ul {
	padding-top: 20px;
	position: relative;
	transition: .5s;

}
.tree li {
	display: inline-table;
	text-align: center;
	list-style-type: none;
	position: relative;
	padding: 3px;
	transition: .5s;
}
.tree li::before, .tree li::after {
	content: '';
	position: absolute;
	top: 0;
	right: 50%;
	border-top: 1px solid #ccc;
	width: 51%;
	height: 10px;
}
.tree li::after {
	right: auto;
	left: 50%;
	border-left: 1px solid #ccc;
}
.tree li:only-child::after, .tree li:only-child::before {
	display: none;
}
.tree li:only-child {
	padding-top: 0;
}
.tree li:first-child::before, .tree li:last-child::after {
	border: 0 none;
}
.tree li:last-child::before {
	border-right: 1px solid #ccc;
	border-radius: 0 5px 0 0;
}
.tree li:first-child::after {
	border-radius: 5px 0 0 0;
}
.tree ul ul::before {
	content: '';
	position: absolute;
	top: 0;
	left: 50%;
	border-left: 1px solid #ccc;
	width: 0;
	height: 20px;
}
.tree li a {
	border: 1px solid #ccc;
	padding-top: 10px;
    padding-left: 5px;
    padding-right: 5px;
	display: inline-grid;
	border-radius: 5px;
	text-decoration-line: none;
	border-radius: 5px;
	transition: .5s;
	width: 100px;
}
.tree li a img {
	width: 40px;
	height: 40px;
	margin-bottom: 5px !important;
	border-radius: 50px;
	margin: auto;
}
.tree li a span {
	border: 1px solid #000000;
	border-radius: 5px;
	color:white;
	padding: 3px;
	font-size: 8px;
	text-transform: uppercase;
	letter-spacing: 1px;
	font-weight: 500;
	background-color: #000;
}

a:hover{
    background: #000000;
	color: #000;
	border: 1px solid #000000;
}



/* The side navigation menu */
.sidenav {
    height: 100%; /* 100% Full-height */
    width: 0; /* 0 width - change this with JavaScript */
    position: fixed; /* Stay in place */
    z-index: 1; /* Stay on top */
    top: 0; /* Stay at the top */
    left: 0;
    background-color: #111; /* Black*/
    overflow-x: hidden; /* Disable horizontal scroll */
    padding-top: 60px; /* Place content 60px from the top */
    transition: 0.5s; /* 0.5 second transition effect to slide in the sidenav */
  }
  
  /* The navigation menu links */
  .sidenav a {
    padding: 8px 8px 8px 32px;
    text-decoration: none;
    font-size: 25px;
    color: #818181;
    display: block;
    transition: 0.3s;
    text-align: center;
  }
  
  /* When you mouse over the navigation links, change their color */
  .sidenav a:hover {
    color: #f1f1f1;
  }
  
  /* Position and style the close button (top right corner) */
  .sidenav .closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px;
    margin-left: 50px;
  }
  
  /* Style page content - use this if you want to push the page content to the right when you open the side navigation */
  #main {
    transition: margin-left .5s;
    padding: 20px;
  }

  /* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
  @media screen and (max-height: 450px) {
    .sidenav {padding-top: 15px;}
    .sidenav a {font-size: 18px;}
  }
 
</style>






