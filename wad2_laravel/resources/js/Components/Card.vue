<script setup>
defineProps({
    imgSrc: {
        type: String,
        default: 'https://static.wikia.nocookie.net/silly-cats/images/8/80/Uni_The_Cat.jpg/revision/latest/scale-to-width-down/1603?cb=20230811130232',
    },
    hover: false
})
</script>
<template>
    <Transition name="fade" mode="out-in" appear>
        <div class="card col-sm-12 col-lg-6 border-dark p-4" :class="{ 'floating-card': hover }" @mouseover="hover = true"
            @mouseleave="hover = false" style="max-width: 540px; margin: 0.5rem;">
            <div class="row g-0">
                <div class="col-4 d-flex align-items-center">
                    <img :src="imgSrc" class="mx-auto" alt="...">
                </div>

                <div class="col-8">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-9">
                                <h5 class="card-title fw-bold">
                                    <slot name="cardTitle" />
                                </h5>
                            </div>
                            <div class="col-2">
                                <slot name="btnRead"/>
                            </div>
                        </div>

                        <p class="card-text">
                            <slot name="cardText" />
                        </p>
                    </div>

                </div>


            </div>
        </div>
    </Transition>
</template>

<style>
.card {
    background-color: rgba(255, 255, 255, 0.9) !important;
}

.card-body{
    border-radius: 0.1vw;
    background-color: rgba(255, 255, 255, 1) !important;
}


.floating-card {
    animation-name: floating;
    animation-duration: 2s;
    animation-iteration-count: infinite;
    animation-timing-function: ease-in-out;
    margin-left: 30px;
    margin-top: 5px;
    box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.55) !important;
}

@keyframes floating-card {
    0% {
        transform: translate(0, 5px);
    }

    50% {
        transform: translate(0, 15px);
    }

    100% {
        transform: translate(0, 5px);
    }
}
</style>