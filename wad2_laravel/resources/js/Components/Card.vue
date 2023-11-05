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
    <Transition name="show" appear>
        <div class="card col-sm-12 col-lg-6 p-4" :class="{ 'floating floating-card': hover }" @mouseover="hover = true"
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
    background-color: rgba(255, 255, 255, 0.95) !important;
}

.card-body{
    border-radius: 0.1vw;
    background-color: rgba(255, 255, 255, 0.1) !important;
}
.show-enter-active,
.show-leave-enter {
    transform: translateX(0);
    transition: all .3s linear;
}
.show-enter,
.show-leave-to {
    transform: translateX(100%);
}

.floating-card {
    box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.55) !important;
}

</style>