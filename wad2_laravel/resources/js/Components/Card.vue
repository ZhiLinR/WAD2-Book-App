
<template>
    <Transition name="fade" mode="out-in" appear>
        <div class="card col-3 m-3 p-0">
            <!--  <img src="..." class="card-img-top" alt="..."> -->
            <div class="card-body">
                <h5 class="card-title">
                    <slot name="cardTitle" />
                </h5>
                <p class="card-text">
                    <slot name="cardText" />
                </p>
            </div>
            <div class="card-footer">
                <a href="#" class="btn btn-primary">View Listing</a>
            </div>
        </div>
    </Transition>
</template>

<style>
.fade-enter-active,
.fade-leave-active {
    transition: opacity 1s ease;
}

.fade-enter-from,
.fade-leave-to {
    opacity: 0;
}
</style>