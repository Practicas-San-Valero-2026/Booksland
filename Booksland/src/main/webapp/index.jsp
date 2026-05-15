<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>

<main>
    <section class="py-5">
        <div class="container">
            <div class="row align-items-center g-5 py-4">
                <div class="col-lg-6">
                    <h1 class="hero-title mb-3">
                        Booksland
                    </h1>
                    <style>
                        .hero-title {
                            font-size: clamp(3rem, 7vw, 5.8rem);
                            font-weight: 900;
                            line-height: 0.95;
                            letter-spacing: -0.04em;
                            margin: 0;
                            background: linear-gradient(90deg, #6b5746 0%, #8b7765 50%, #b29d88 100%);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                            background-clip: text;
                            text-shadow: 0 6px 18px rgba(107, 87, 70, 0.10);
                        }

                        .hero-subtitle {
                            font-size: 1.2rem;
                            max-width: 620px;
                        }

                        .hero-badge {
                            letter-spacing: 0.08em;
                            text-transform: uppercase;
                        }
                    </style>
                    <h2 class="display-5 fw-bold lh-1 mb-3">
                        Your next adventure starts here
                    </h2>

                    <div class="d-flex flex-wrap gap-2">
                        <a href="<%= contextPath %>/books" class="btn btn-secondary btn-lg px-4">
                            Books
                        </a>
                        <a href="<%= contextPath %>/authors" class="btn btn-outline-secondary btn-lg px-4">
                            Authors
                        </a>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="p-4 p-md-5 border rounded-4 shadow-sm bg-body-tertiary">
                        <h2 class="h4 fw-bold mb-3">Discover your favourite genres</h2>
                        <div class="row g-3">
                            <div class="col-12 col-sm-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <h3 class="h6 fw-bold">Thriller</h3>
                                        <p class="text-body-secondary mb-0">Fast-paced stories full of suspense, tension
                                            and unexpected twists.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 col-sm-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <h3 class="h6 fw-bold">Crime</h3>
                                        <p class="text-body-secondary mb-0">Stories centered on crimes, investigations,
                                            criminals and justice.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 col-sm-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <h3 class="h6 fw-bold">History</h3>
                                        <p class="text-body-secondary mb-0">Books that explore past events, societies and
                                            historical figures.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 col-sm-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <h3 class="h6 fw-bold">Literature</h3>
                                        <p class="text-body-secondary mb-0">Fiction and classic works focused on style,
                                            themes and human experience.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 bg-body-tertiary border-top border-bottom">
        <div class="container">
            <div class="row g-4 text-center">
                <div class="col-md-4">
                    <div class="p-4">
                        <i class="bi bi-book fs-1 text-primary mb-3"></i>
                        <h2 class="h5 fw-bold">Huge catalogue</h2>
                        <p class="text-body-secondary mb-0">
                            Explore our books and find the genre that fits the most with your personality.
                        </p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="p-4">
                        <i class="bi bi-tags fs-1 text-danger mb-3"></i>
                        <h2 class="h5 fw-bold">Amazing discounts</h2>
                        <p class="text-body-secondary mb-0">
                            The best discounts you will ever find online.
                        </p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="p-4">
                        <i class="bi bi-cart-check fs-1 text-success mb-3"></i>
                        <h2 class="h5 fw-bold">Easy-peasy shopping</h2>
                        <p class="text-body-secondary mb-0">
                            Buy in a few seconds.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="includes/footer.jsp"%>

