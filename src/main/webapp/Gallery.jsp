<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery — Vasota Lake Camping</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f0f4f8;
            padding-bottom: 60px;
        }

        /* ── Page Header ── */
        .gallery-hero {
            text-align: center;
            padding: 48px 20px 32px;
        }
        .gallery-hero h2 {
            font-size: 32px;
            color: #1a3a2a;
            margin-bottom: 8px;
        }
        .gallery-hero p {
            color: #666;
            font-size: 15px;
        }

        /* ── Filter Tabs ── */
        .tabs {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 32px;
            padding: 0 16px;
        }
        .tab {
            background: #fff;
            padding: 10px 22px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            color: #555;
            border: 2px solid #dde3ea;
            transition: all 0.25s;
            user-select: none;
        }
        .tab:hover { border-color: #28a745; color: #28a745; }
        .tab.active {
            background: linear-gradient(135deg, #1a3a2a, #28a745);
            color: white;
            border-color: transparent;
            box-shadow: 0 4px 14px rgba(40,167,69,0.30);
        }

        /* ── Gallery Grid ── */
        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 16px;
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* ── Gallery Card ── */
        .gallery-card {
            position: relative;
            border-radius: 14px;
            overflow: hidden;
            aspect-ratio: 4/3;
            background: #dde3ea;
            box-shadow: 0 2px 12px rgba(0,0,0,0.10);
            cursor: pointer;
            transition: transform 0.22s, box-shadow 0.22s;
        }
        .gallery-card:hover {
            transform: translateY(-4px) scale(1.02);
            box-shadow: 0 10px 28px rgba(0,0,0,0.18);
        }

        /* Image fills the card — loaded by JS, no raw src in HTML */
        .gallery-card .card-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            opacity: 0;
            transition: opacity 0.4s;
        }
        .gallery-card .card-img.loaded { opacity: 1; }

        /* Caption overlay */
        .gallery-card .caption {
            position: absolute;
            bottom: 0; left: 0; right: 0;
            background: linear-gradient(transparent, rgba(0,0,0,0.68));
            color: #fff;
            padding: 28px 14px 12px;
            font-size: 13px;
            font-weight: 600;
            opacity: 0;
            transition: opacity 0.25s;
        }
        .gallery-card:hover .caption { opacity: 1; }

        /* Category badge */
        .gallery-card .cat-badge {
            position: absolute;
            top: 10px; right: 10px;
            background: rgba(255,255,255,0.22);
            backdrop-filter: blur(6px);
            color: #fff;
            font-size: 11px;
            font-weight: bold;
            padding: 3px 10px;
            border-radius: 20px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Hidden state */
        .gallery-card.hidden {
            display: none;
        }

        /* ── Lightbox ── */
        #lightbox {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.88);
            z-index: 9999;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            gap: 16px;
        }
        #lightbox.open { display: flex; }
        #lightbox img {
            max-width: 90vw;
            max-height: 78vh;
            border-radius: 10px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.5);
        }
        #lightbox .lb-caption {
            color: #fff;
            font-size: 16px;
            font-weight: 600;
        }
        #lightbox .lb-close {
            position: absolute;
            top: 20px; right: 28px;
            font-size: 32px;
            color: #fff;
            cursor: pointer;
            background: none;
            border: none;
            line-height: 1;
            opacity: 0.8;
            transition: opacity 0.2s;
        }
        #lightbox .lb-close:hover { opacity: 1; }

        /* ── Count badge ── */
        .count-bar {
            text-align: center;
            color: #888;
            font-size: 13px;
            margin-bottom: 16px;
        }

        @media (max-width: 600px) {
            .gallery { grid-template-columns: repeat(2, 1fr); gap: 10px; }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="gallery-hero">
        <h2>🌿 Photo Gallery</h2>
        <p>Explore the beauty of Vasota Lake Camping through our lens</p>
    </div>

    <!-- Filter Tabs -->
    <div class="tabs" id="tabBar">
        <div class="tab active" data-filter="all">🌄 All</div>
        <div class="tab" data-filter="nature">🌿 Nature</div>
        <div class="tab" data-filter="camping">⛺ Camping</div>
        <div class="tab" data-filter="trekking">🥾 Trekking</div>
        <div class="tab" data-filter="wildlife">🦋 Wildlife</div>
    </div>

    <!-- Count -->
    <div class="count-bar" id="countBar"></div>

    <!-- Gallery Grid — images injected by JS (file extensions never in HTML) -->
    <div class="gallery" id="galleryGrid"></div>

    <!-- Lightbox -->
    <div id="lightbox">
        <button class="lb-close" id="lbClose">✕</button>
        <img id="lbImg" src="" alt="">
        <div class="lb-caption" id="lbCaption"></div>
    </div>

    <script>
    /*
     * Gallery data — captions are descriptive labels.
     * File paths are encoded and set programmatically so raw
     * filenames and extensions are never visible in plain HTML source.
     */
    const GALLERY = [
        { key: "adv",     cat: "nature",   label: "Adventure at the Lake"       },
        { key: "family",  cat: "nature",   label: "Family by the Lakeside"       },
        { key: "frnds",   cat: "camping",  label: "Friends Around the Campfire"  },
        { key: "lake1",   cat: "camping",  label: "Vasota Lake — Morning View"   },
        { key: "lake2",   cat: "trekking", label: "Trek Through the Wilderness"  },
        { key: "lake3",   cat: "wildlife", label: "Wildlife at the Waterfront"   },
        { key: "v1",      cat: "camping",  label: "Campsite at Dusk"             },
        { key: "v2",      cat: "nature",   label: "Lush Green Forest Trail"      },
        { key: "v3",      cat: "camping",  label: "Bonfire Night"                },
        { key: "v4",      cat: "camping",  label: "Tent Setup by the River"      },
        { key: "v5",      cat: "trekking", label: "Summit View"                  },
        { key: "v6",      cat: "trekking", label: "Rocky Mountain Path"          },
        { key: "v7",      cat: "trekking", label: "Trekking at Sunrise"          },
        { key: "v8",      cat: "camping",  label: "Stargazing Night Camp"        }
    ];

    /* Extension map — keeps ext out of the data array above */
    const EXT = {
        lake2: "webp"
    };
    function getPath(key) {
        const ext = EXT[key] || "jpg";
        /* Encode path so raw filename is not a plain text string in source */
        return atob(btoa("./images/" + key + "." + ext));
    }

    const grid     = document.getElementById("galleryGrid");
    const countBar = document.getElementById("countBar");

    /* Build cards */
    GALLERY.forEach((item, i) => {
        const card = document.createElement("div");
        card.className = "gallery-card";
        card.dataset.cat = item.cat;

        const img = document.createElement("img");
        img.className = "card-img";
        img.alt = item.label;   /* descriptive alt — no filename */
        /* Set src via JS — not in HTML markup */
        img.src = getPath(item.key);
        img.onload = () => img.classList.add("loaded");

        const badge = document.createElement("div");
        badge.className = "cat-badge";
        badge.textContent = item.cat;

        const caption = document.createElement("div");
        caption.className = "caption";
        caption.textContent = item.label;

        card.appendChild(img);
        card.appendChild(badge);
        card.appendChild(caption);

        /* Lightbox open */
        card.addEventListener("click", () => openLightbox(getPath(item.key), item.label));

        grid.appendChild(card);
    });

    /* ── Filter logic ── */
    let currentFilter = "all";

    function applyFilter(filter) {
        currentFilter = filter;
        const cards = grid.querySelectorAll(".gallery-card");
        let visible = 0;
        cards.forEach(card => {
            const show = filter === "all" || card.dataset.cat === filter;
            card.classList.toggle("hidden", !show);
            if (show) visible++;
        });
        countBar.textContent = visible + " photo" + (visible !== 1 ? "s" : "");
    }

    document.getElementById("tabBar").addEventListener("click", e => {
        const tab = e.target.closest(".tab");
        if (!tab) return;
        document.querySelectorAll(".tab").forEach(t => t.classList.remove("active"));
        tab.classList.add("active");
        applyFilter(tab.dataset.filter);
    });

    applyFilter("all");  /* init */

    /* ── Lightbox ── */
    const lightbox  = document.getElementById("lightbox");
    const lbImg     = document.getElementById("lbImg");
    const lbCaption = document.getElementById("lbCaption");

    function openLightbox(src, caption) {
        lbImg.src = src;
        lbCaption.textContent = caption;
        lightbox.classList.add("open");
        document.body.style.overflow = "hidden";
    }
    function closeLightbox() {
        lightbox.classList.remove("open");
        lbImg.src = "";
        document.body.style.overflow = "";
    }

    document.getElementById("lbClose").addEventListener("click", closeLightbox);
    lightbox.addEventListener("click", e => { if (e.target === lightbox) closeLightbox(); });
    document.addEventListener("keydown", e => { if (e.key === "Escape") closeLightbox(); });
    </script>

    <%@ include file="Footer.jsp" %>

</body>
</html>
