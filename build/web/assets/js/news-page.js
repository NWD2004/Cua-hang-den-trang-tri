(() => {
  const ctx = (window.LIGHTSTORE && window.LIGHTSTORE.contextPath) || '';
  const apiUrl = `${ctx}/api/news`;

  const els = {
    heroTitle: document.getElementById('newsHeroTitle'),
    heroSubtitle: document.getElementById('newsHeroSubtitle'),
    heroTags: document.getElementById('newsHeroTags'),
    featured: document.getElementById('featuredArticle'),
    latest: document.getElementById('latestList'),
    categories: document.getElementById('categoryList'),
    popular: document.getElementById('popularList'),
    insights: document.getElementById('insightsList')
  };

  const fallback = {
    hero: {
      title: 'Tin tức ánh sáng LightStore',
      subtitle: 'Bài viết mới nhất về công nghệ chiếu sáng, phong cách décor và case study thực tế do LightStore thực hiện.',
      tags: ['Lighting Insider', 'Case Study', 'Tips']
    },
    featured: {
      title: 'LightStore ra mắt bộ sưu tập Aurora Edition',
      excerpt: 'Bộ sản phẩm đèn trần ứng dụng vật liệu tái chế, tích hợp chip LED CRI 95.',
      image: 'https://images.unsplash.com/photo-1470246973918-29a93221c455?auto=format&fit=crop&w=1200&q=80',
      author: 'LightStore Lab',
      date: '01/11/2025',
      readingTime: '4 phút đọc',
      stats: { views: '8.9k', shares: '430', bookmarks: '120' }
    },
    latest: [],
    categories: [],
    popular: [],
    insights: []
  };

  fetch(apiUrl)
    .then((res) => {
      if (!res.ok) throw new Error('API_ERROR');
      return res.json();
    })
    .then(renderNews)
    .catch(() => renderNews(fallback));

  function renderNews(data) {
    renderHero(data.hero || fallback.hero);
    renderFeatured(data.featured || fallback.featured);
    renderLatest(data.latest || fallback.latest);
    renderCategories(data.categories || fallback.categories);
    renderPopular(data.popular || fallback.popular);
    renderInsights(data.insights || fallback.insights);
  }

  function renderHero(hero) {
    if (els.heroTitle) {
      els.heroTitle.textContent = hero.title || '';
    }
    if (els.heroSubtitle) {
      els.heroSubtitle.textContent = hero.subtitle || '';
    }
    if (els.heroTags) {
      els.heroTags.innerHTML = (hero.tags || [])
        .map((tag) => `<span class="news-chip">${tag}</span>`)
        .join('');
    }
  }

  function renderFeatured(post) {
    if (!els.featured) return;
    const stats = post.stats || {};
    els.featured.innerHTML = `
      <div class="featured-card">
        <div class="featured-media">
          <img src="${post.image}" alt="${post.title}">
          <span class="featured-label">${post.category || 'Góc chuyên gia'}</span>
        </div>
        <div class="featured-body">
          <div class="featured-meta">
            <span><i class="fa-regular fa-calendar"></i>${post.date || ''}</span>
            <span><i class="fa-regular fa-user"></i>${post.author || ''}</span>
            <span><i class="fa-regular fa-clock"></i>${post.readingTime || ''}</span>
            <span><i class="fa-regular fa-eye"></i>${stats.views || ''}</span>
          </div>
          <h2 class="featured-title">${post.title}</h2>
          <p class="featured-excerpt">${post.excerpt}</p>
          <a href="#" class="featured-cta">Đọc chi tiết <i class="fa-solid fa-arrow-right"></i></a>
        </div>
      </div>
    `;
  }

  function renderLatest(list) {
    if (!els.latest) return;
    if (!list.length) {
      els.latest.innerHTML = `<p class="text-muted">Chưa có bài viết mới.</p>`;
      return;
    }

    els.latest.innerHTML = list
      .map(
        (item) => `
        <article class="news-card">
          <img src="${item.image}" alt="${item.title}">
          <div class="news-card__content">
            <div class="badge">${item.badge || item.category || ''}</div>
            <h3>${item.title}</h3>
            <p>${item.excerpt}</p>
            <div class="news-meta">
              <span><i class="fa-regular fa-calendar"></i>${item.date}</span>
              <span><i class="fa-regular fa-eye"></i>${item.views}</span>
              <span><i class="fa-regular fa-clock"></i>${item.readingTime}</span>
            </div>
          </div>
        </article>
      `
      )
      .join('');
  }

  function renderCategories(items) {
    if (!els.categories) return;
    els.categories.innerHTML = (items || [])
      .map(
        (cat) => `
        <li>
          <button type="button">
            <span>${cat.name}</span>
            <span>${cat.count}</span>
          </button>
        </li>
      `
      )
      .join('');
  }

  function renderPopular(items) {
    if (!els.popular) return;
    els.popular.innerHTML = (items || [])
      .map(
        (post) => `
        <article class="popular-item">
          <img src="${post.image}" alt="${post.title}">
          <div>
            <h4>${post.title}</h4>
            <div class="news-meta">
              <span><i class="fa-regular fa-calendar"></i>${post.date}</span>
              <span><i class="fa-regular fa-clock"></i>${post.readingTime}</span>
            </div>
          </div>
        </article>
      `
      )
      .join('');
  }

  function renderInsights(items) {
    if (!els.insights) return;
    els.insights.innerHTML = (items || [])
      .map(
        (insight) => `
        <div class="insight-card">
          <span class="news-muted">${insight.label}</span>
          <strong>${insight.value}</strong>
          ${
            insight.delta
              ? `<span class="insight-trend ${insight.trend === 'down' ? 'down' : ''}">${insight.delta}</span>`
              : ''
          }
        </div>
      `
      )
      .join('');
  }
})();

