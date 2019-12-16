function scrollMenu() {
    let espan = document.getElementById('b');
    if (espan) {
        let navi = document.getElementById('navi');
        if (navi) {
            console.log('has navi');
            let offsetleft = espan.offsetLeft;
            let scrollOffset = Math.abs(navi.scrollWidth - espan.offsetWidth) * 0.5;
            navi.scrollTo(scrollOffset, 0);
        }
    }
}