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
            publicPath: import.meta.env.BASE_URL
        }
    },
    mounted() {


        Promise.all([this.data]).then(result => {
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



        })



    },
    methods: {


        createTree(item, id) {
            const { left, right, head } = item
            var number = Math.floor(Math.random() * (12 - 1 + 1)) + 1
            var add = id+number
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
           
            for (var i=0;i<img.length;i++) {

                var identifier = img.className
                var rando = identifier+number

                img[i].src="/"+identifier+"/gif/"+rando+".gif"

                
            }
        },

        async addItem(item, identifier) {

            let data, url;

            switch (identifier) {
                case "Fantasy":
                    data = await this.fantasy;
                    url = "/api/skilltree/update-fantasy-object";
                    break;
                case "Mystery":
                    data = await this.mystery;
                    url = "/api/skilltree/update-mystery-object";
                    break;
                case "Romance":
                    data = await this.romance;
                    url = "/api/skilltree/update-romance-object";
                    break;
                case "Nonfiction":
                    data = await this.nonfiction;
                    url = "/api/skilltree/update-nonfiction-object";
                    break;
                case "Horror":
                    data = await this.horror;
                    url = "/api/skilltree/update-horror-object";
                    break;
                default:
                    console.log("Invalid identifier");
                    return;
            }
            var node = this.bfs(data, item);
            if(node != false){
            node.left = { head: "Own reco" };
            node.right = { head: "Testing Computer Software" };

            var sql = JSON.stringify(data);


            this.sendData(url, sql);
            location.reload()}
            else{
                alert("Please select another node")
            }
        },
        addingBook() {
            
            var title = document.getElementById("cardtitle")
            var identifier = title.className
            if(identifier.search("fantasy")!=-1){
                
                
                this.addItem(title.innerHTML,"Fantasy")
            }
            else if(identifier.search("horror")!=-1){
               
                
                this.addItem(title.innerHTML,"Horror")
            }
            else if(identifier.search("nonfiction")!=-1){
                
                this.addItem(title.innerHTML,"Nonfiction")
            }
            else if(identifier.search("romance")!=-1){
                
                
                this.addItem(title.innerHTML,"Romance")
            }
            else if(identifier.search("mystery")!=-1){
                
                
                this.addItem(title.innerHTML,"Mystery")
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
            var queue = [obj]

            while (queue.length > 0) {
                var check = queue.shift()
                console.log(check)
                var headChecker = check.head.replace("'", "")
                var findChecker = find.replace("'", "")

                if (headChecker == findChecker) {
                    if (find == "Own Reco") {
                        alert("This is an empty node")
                    }
                    else if (check.hasOwnProperty("left") || check.hasOwnProperty("right")) {
                        alert("Please select another node")
                        
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
            if ((book === "Own reco"  || event.target.localName == "li"|| event.target.localName == "ul")) {

                this.closeNav()
            }
            else if(book == "Fantasy" || book == "Mystery" || book == "Romance" || book == "Nonfiction" || book == "Horror"){
                var url ="/api/skilltree/get-read-object"
                book = book.toLowerCase()
                var book_read =book+"_read"
       
                axios.post(url, {
                genre: book_read
                })
                .then(response => {
                    var read = response.data
                    var list = JSON.parse(read)
                    
                    var count = 0
                    for(var i=0;i<list.length;i++){
                        count+=1
                    }
                    var sidenav = document.getElementById("mySidenav")
                sidenav.style.width = "300px"
                var thumbnail = document.getElementById("thumbnail")
                var title = document.getElementById("cardtitle")
                var desc = document.getElementById("carddesc")
                var button = document.getElementById("completed")
                var left = 10 -count
                if(left<0){
                    left ="completed"
                }
                button.style.display ="none"
                title.innerHTML =`${book}`
                desc.innerHTML =   `Number of ${book} read: ${count}<br> Number of books till Animations: ${left}`
                thumbnail.src =`/main/${book}.jpeg`
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
                        title.className ="card-title "+genre
                        title.innerHTML = cardtitle
                        desc.innerHTML = carddesc
                        var button = document.getElementById("completed")
                button.style.display =""

                    })

                    .catch(error => {
                        console.error(error);
                    });
            }
        },



    


    manualSearch(event) {
        var book = document.getElementById("bookname").value
        var author = document.getElementById("author").value
        console.log(event.type)
        const url = 'https://www.googleapis.com/books/v1/volumes'

        if (book == "") {
            alert("Please key in a book")
        }
        else {
            //user knows title and author
            if (author != "") {
                var query = `intitle:${book} inauthor:${author}`;
            }
            //user knows title but NOT author
            else if (this.input != '' && this.input2 == '') {
                var query = `intitle:${book}`;
            }
            const params = {
                q: query,
                maxResults: 20
            };
            axios.get(url, {
                params
            })
                .then(response => {
                    var card =''
                    var booklist = response.data.items
                    console.log(booklist)
                    var sidenav = document.getElementById("mySidenav")
                    sidenav.style.width = "300px"
                    
                   
                    for(var i=0;i<booklist.list;i++){
                        var img = bookslist[i].volumeInfo.imageLinks.thumbnail
                        card +=`<div class="card" style="width: 18rem;">
<img class="card-img-top" src="${img}" alt="Card image cap">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <a href="#" class="btn btn-primary">Go somewhere</a>
  </div>
</div>`
                    }
                    console.log(card)
                    var carddiv = document.getElementById("card")
                    carddiv.innerHTML =card

                })

                .catch(error => {
                    console.error(error);
                });


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
    addOwnReco() {
        var horror_tree = this.horror

        var target = "Own reco"
        const replacement = {
            head: "test",
            left: { head: "left" },
            right: { head: "right" }
        };

        this.bfsAndUpdate(horror_tree, target, replacement)
        const updated = JSON.stringify(horror_tree)
        var url = "/api/skilltree/update-horror-object"
        this.sendData(url, updated)
        // location.reload()


    }
    ,

    getRandomSubject(genre) {
        const url = 'https://www.googleapis.com/books/v1/volumes';
        const searchTermSubject = genre; //change to that specific book genre based on what is clicked

        var query = `subject:${searchTermSubject}`

        const params = {
            q: query,
            maxResults: 40
        }

        axios.get(url, {
            params
        })

            .then(response => {
                var data = response.data.items


                let randomIndex = Math.floor(Math.random() * 20);

                if (data[randomIndex]) {
                    let item = data[randomIndex]
                    let title = item.volumeInfo.title
                    let desc = item.volumeInfo.description
                    let image = item.volumeInfo.imageLinks.thumbnail



                }
            })
    },




}}


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

            
            <!-- card2 -->
            <div class="card" style="max-width: 18rem;">
                <img id ='thumbnail' class="card-img-top" alt="Card image cap" max-width="300px" >
                <div class="card-body">
                  <h5 class="card-title" id ="cardtitle"></h5>
                  <p class="card-text" id = "carddesc">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                  <a href="#" class="btn btn-primary" @click="addingBook" id="completed"><span style="text-align: center;">I have COMPLETED IT!</span></a>
                </div>
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
<div class="container-fluid">
    <div class="input-group mb-3 col-3">
        <input id ="bookname" type="text" class="form-control" placeholder="Book Name" aria-label="Recipient's username" aria-describedby="basic-addon2">
        <input id ="author" type="text" class="form-control" placeholder="Author" aria-label="Recipient's username" aria-describedby="basic-addon2">
        <div class="input-group-append">
          <button class="btn btn-outline-secondary" type="button" @click="manualSearch" >Search</button>
        </div>
      </div>
</div>


<button type="button" class="btn btn-light" @click="getRandomSubject">Light</button>
    </AuthenticatedLayout>
</template>

<style>
body {
    background-color: rgb(34, 33, 33);
}


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