<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%-- ═══════════════════════════════════════════════════════════
     Vasota Lake Camping — AI Chatbot Widget
     Uses Google Gemini API (gemini-1.5-flash)
     Pure frontend — zero backend changes required.
     Include this file at the bottom of Footer.jsp.
     ═══════════════════════════════════════════════════════════ --%>

<style>
/* ── Chatbot Widget ─────────────────────────────────────── */
#vl-chat-bubble {
    position: fixed;
    bottom: 28px;
    right: 28px;
    z-index: 99999;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 12px;
}

/* Floating toggle button */
#vl-chat-toggle {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: linear-gradient(135deg, #1aa356, #0A2E1F);
    border: none;
    cursor: pointer;
    box-shadow: 0 6px 24px rgba(26,163,86,0.45);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 26px;
    transition: transform 0.3s, box-shadow 0.3s;
    position: relative;
    flex-shrink: 0;
}
#vl-chat-toggle:hover {
    transform: scale(1.1);
    box-shadow: 0 10px 30px rgba(26,163,86,0.55);
}
#vl-chat-toggle .vl-toggle-icon { transition: transform 0.35s, opacity 0.25s; }
#vl-chat-toggle .vl-toggle-close {
    position: absolute;
    font-size: 20px;
    opacity: 0;
    transform: rotate(-90deg) scale(0.5);
    transition: all 0.3s;
}
#vl-chat-bubble.open #vl-chat-toggle .vl-toggle-icon  { opacity: 0; transform: rotate(90deg) scale(0.5); }
#vl-chat-bubble.open #vl-chat-toggle .vl-toggle-close { opacity: 1; transform: rotate(0deg) scale(1); }

/* Unread badge */
#vl-chat-badge {
    position: absolute;
    top: -4px; right: -4px;
    background: #e74c3c;
    color: white;
    font-size: 10px;
    font-weight: 700;
    width: 18px; height: 18px;
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    border: 2px solid white;
    display: none;
}

/* Chat window */
#vl-chat-window {
    width: 370px;
    max-height: 520px;
    background: white;
    border-radius: 18px;
    box-shadow: 0 16px 48px rgba(0,0,0,0.18);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    transform-origin: bottom right;
    transform: scale(0.85) translateY(20px);
    opacity: 0;
    pointer-events: none;
    transition: transform 0.35s cubic-bezier(0.34,1.56,0.64,1), opacity 0.25s ease;
    border: 1px solid rgba(26,163,86,0.15);
}
#vl-chat-bubble.open #vl-chat-window {
    transform: scale(1) translateY(0);
    opacity: 1;
    pointer-events: all;
}

/* Header */
.vl-chat-head {
    background: linear-gradient(135deg, #1aa356 0%, #0A2E1F 100%);
    color: white;
    padding: 14px 18px;
    display: flex;
    align-items: center;
    gap: 12px;
    flex-shrink: 0;
}
.vl-head-avatar {
    width: 40px; height: 40px;
    background: rgba(255,255,255,0.2);
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 20px;
    flex-shrink: 0;
    border: 2px solid rgba(255,255,255,0.3);
}
.vl-head-info { flex: 1; }
.vl-head-info .vl-bot-name { font-size: 15px; font-weight: 700; }
.vl-head-info .vl-bot-status {
    font-size: 11px; opacity: 0.8;
    display: flex; align-items: center; gap: 5px; margin-top: 2px;
}
.vl-status-dot {
    width: 7px; height: 7px;
    background: #5dde8b;
    border-radius: 50%;
    animation: vl-pulse 2s infinite;
}
@keyframes vl-pulse {
    0%,100% { opacity:1; transform:scale(1); }
    50%      { opacity:0.5; transform:scale(1.4); }
}
.vl-head-clear {
    background: rgba(255,255,255,0.15);
    border: none; cursor: pointer;
    color: white; border-radius: 8px;
    padding: 5px 9px; font-size: 11px;
    transition: background 0.2s;
}
.vl-head-clear:hover { background: rgba(255,255,255,0.28); }

/* Messages area */
#vl-chat-msgs {
    flex: 1;
    overflow-y: auto;
    padding: 16px 14px;
    display: flex;
    flex-direction: column;
    gap: 12px;
    background: #f8faf9;
    scroll-behavior: smooth;
}
#vl-chat-msgs::-webkit-scrollbar { width: 4px; }
#vl-chat-msgs::-webkit-scrollbar-track { background: transparent; }
#vl-chat-msgs::-webkit-scrollbar-thumb { background: #c8e6c9; border-radius: 4px; }

/* Message bubbles */
.vl-msg { display: flex; gap: 8px; align-items: flex-end; max-width: 90%; }
.vl-msg.bot  { align-self: flex-start; }
.vl-msg.user { align-self: flex-end; flex-direction: row-reverse; }

.vl-msg-avatar {
    width: 28px; height: 28px;
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 14px; flex-shrink: 0;
    background: linear-gradient(135deg, #1aa356, #0A2E1F);
    color: white;
}
.vl-msg.user .vl-msg-avatar {
    background: linear-gradient(135deg, #3b82f6, #1e40af);
}

.vl-bubble {
    padding: 10px 14px;
    border-radius: 16px;
    font-size: 13.5px;
    line-height: 1.6;
    max-width: 100%;
    word-wrap: break-word;
}
.vl-msg.bot  .vl-bubble {
    background: white;
    color: #333;
    border-bottom-left-radius: 4px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    border: 1px solid rgba(0,0,0,0.06);
}
.vl-msg.user .vl-bubble {
    background: linear-gradient(135deg, #1aa356, #128a42);
    color: white;
    border-bottom-right-radius: 4px;
}

/* Typing indicator */
.vl-typing .vl-bubble {
    display: flex; align-items: center; gap: 4px;
    padding: 12px 16px;
}
.vl-typing-dot {
    width: 7px; height: 7px;
    background: #aaa;
    border-radius: 50%;
    animation: vl-bounce 1.2s infinite;
}
.vl-typing-dot:nth-child(2) { animation-delay: 0.2s; }
.vl-typing-dot:nth-child(3) { animation-delay: 0.4s; }
@keyframes vl-bounce {
    0%,60%,100% { transform: translateY(0); }
    30%          { transform: translateY(-6px); }
}

/* Timestamp */
.vl-msg-time {
    font-size: 10px;
    color: #aaa;
    margin-top: 3px;
    padding: 0 4px;
    align-self: flex-end;
}

/* Quick replies */
.vl-quick-replies {
    display: flex; flex-wrap: wrap; gap: 7px;
    padding: 8px 14px 0;
}
.vl-qr-btn {
    background: white;
    border: 1.5px solid #1aa356;
    color: #1aa356;
    border-radius: 20px;
    padding: 5px 12px;
    font-size: 12px;
    cursor: pointer;
    transition: all 0.2s;
    white-space: nowrap;
}
.vl-qr-btn:hover { background: #1aa356; color: white; }

/* Input area */
.vl-chat-input-wrap {
    padding: 12px 14px;
    background: white;
    border-top: 1px solid #eee;
    display: flex;
    gap: 8px;
    align-items: flex-end;
    flex-shrink: 0;
}
#vl-chat-input {
    flex: 1;
    border: 1.5px solid #e0e0e0;
    border-radius: 20px;
    padding: 9px 14px;
    font-size: 13.5px;
    resize: none;
    outline: none;
    font-family: inherit;
    line-height: 1.4;
    max-height: 80px;
    overflow-y: auto;
    transition: border-color 0.2s;
    background: #f8faf9;
}
#vl-chat-input:focus { border-color: #1aa356; background: white; }
#vl-chat-input::placeholder { color: #bbb; }

#vl-send-btn {
    width: 38px; height: 38px;
    background: linear-gradient(135deg, #1aa356, #128a42);
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: flex; align-items: center; justify-content: center;
    color: white; font-size: 16px;
    flex-shrink: 0;
    transition: transform 0.2s, box-shadow 0.2s;
    box-shadow: 0 3px 10px rgba(26,163,86,0.3);
}
#vl-send-btn:hover:not(:disabled) { transform: scale(1.1); box-shadow: 0 5px 15px rgba(26,163,86,0.4); }
#vl-send-btn:disabled { opacity: 0.5; cursor: not-allowed; transform: none; }

/* API error notice */
.vl-api-notice {
    font-size: 10px;
    text-align: center;
    color: #bbb;
    padding: 4px 14px 8px;
    background: white;
}

@media (max-width: 480px) {
    #vl-chat-window { width: calc(100vw - 32px); }
    #vl-chat-bubble { right: 16px; bottom: 16px; }
}
</style>

<!-- ═══════════════════════════════════════════════════════════
     Chatbot Widget HTML
     ═══════════════════════════════════════════════════════════ -->
<div id="vl-chat-bubble">

    <!-- Chat Window -->
    <div id="vl-chat-window" role="dialog" aria-label="Vasota Camping Assistant">

        <!-- Header -->
        <div class="vl-chat-head">
            <div class="vl-head-avatar">🏕️</div>
            <div class="vl-head-info">
                <div class="vl-bot-name">Camp Assistant</div>
                <div class="vl-bot-status">
                    <span class="vl-status-dot"></span> Online · Vasota Lake Camping
                </div>
            </div>
            <button class="vl-head-clear" onclick="vlClearChat()" title="Clear chat">🗑 Clear</button>
        </div>

        <!-- Messages -->
        <div id="vl-chat-msgs" aria-live="polite"></div>

        <!-- Quick Replies -->
        <div class="vl-quick-replies" id="vl-quick-replies">
            <button class="vl-qr-btn" onclick="vlQuickSend('What are the tent options?')">🏕️ Tent Types</button>
            <button class="vl-qr-btn" onclick="vlQuickSend('How do I book a camp?')">📅 How to Book</button>
            <button class="vl-qr-btn" onclick="vlQuickSend('What is the price per person?')">💰 Pricing</button>
            <button class="vl-qr-btn" onclick="vlQuickSend('Contact number of the camp')">📞 Contact</button>
        </div>

        <!-- Input -->
        <div class="vl-chat-input-wrap">
            <textarea
                id="vl-chat-input"
                placeholder="Ask me anything about the camp…"
                rows="1"
                onkeydown="vlHandleKey(event)"
                oninput="vlAutoResize(this)"
                aria-label="Chat input"
            ></textarea>
            <button id="vl-send-btn" onclick="vlSend()" aria-label="Send message">➤</button>
        </div>
        <div class="vl-api-notice">Powered by Google Gemini AI</div>
    </div>

    <!-- Toggle Bubble -->
    <button id="vl-chat-toggle" onclick="vlToggle()" aria-label="Open chat assistant" title="Chat with us!">
        <span class="vl-toggle-icon">💬</span>
        <span class="vl-toggle-close">✕</span>
        <span id="vl-chat-badge">1</span>
    </button>
</div>

<!-- ═══════════════════════════════════════════════════════════
     Chatbot JavaScript — Gemini API Integration
     ═══════════════════════════════════════════════════════════ -->
<script>
(function () {
    /* ── CONFIG ──────────────────────────────────────────────── */
    // API key is now stored server-side in GeminiProxy.java
    // The browser calls our own /GeminiProxy servlet — the key is never exposed!
    const API_URL = window.location.pathname.replace(/\/[^/]*$/, '') + '/GeminiProxy';

    /* ── SYSTEM PROMPT ───────────────────────────────────────── */
    const SYSTEM_PROMPT = `You are "Camp Assistant", a friendly and helpful AI chatbot for Vasota Lake Camping — a nature camping site located near Vasota Fort, Koyna Backwaters, Maharashtra, India.

Your role:
- Answer questions clearly, concisely, and helpfully.
- Keep responses short (2-4 sentences) unless a detailed explanation is needed.
- Use a warm, friendly, and professional tone.
- Add relevant emojis to make responses feel lively.

CAMP DETAILS YOU KNOW:
📍 Location: Vasota Fort, Koyna Backwaters, Maharashtra, India
📞 Contact: +91 9579350747
📧 Email: vasotalakecamping@gmail.com

🏕️ ACCOMMODATION OPTIONS & PRICING:
1. Regular Tent      — ₹800/person   (up to 4 people)
2. Triangle Tent     — ₹1,200/person (up to 2 people)
3. Machan Cottage    — ₹2,500/person (up to 4 people)
4. Elevator Cottage  — ₹3,500/person (up to 4 people)
5. Glamping Tent     — ₹5,000/person (up to 3 people)
6. Ultra Luxury Cottage — ₹8,000/person (up to 6 people)

🎯 ACTIVITIES: Trekking, Boating, Bonfire, Stargazing, Vasota Fort Trek, Eco-camping

💳 PAYMENT: Pay on arrival via UPI (Paytm QR: 9579350747@ptyes) or send screenshot to 9579350747

📅 BOOKING: Users can book online at the website. They choose tent type, arrival/departure dates, number of adults & kids.

ℹ️ GENERAL INFO:
- 500+ happy campers served
- 4.9★ guest rating
- 3 years in business
- Eco-friendly practices
- Kids accommodation is FREE

HOW TO BOOK (step by step):
1. Click "Book Now" on the homepage
2. Fill in your name, email, phone
3. Choose tent type and dates
4. Select number of adults and kids
5. Choose payment method (online or pay on arrival)
6. Submit — you'll get a confirmation page with booking ID

If asked about something outside your knowledge, politely say: "I'm not sure about that — please contact us at 9579350747 or vasotalakecamping@gmail.com for more help! 😊"

IMPORTANT: Never make up prices or details not listed above. Always be accurate.`;

    /* ── STATE ───────────────────────────────────────────────── */
    let conversationHistory = [];
    let isBotTyping = false;
    let isOpen = false;
    let hasShownWelcome = false;

    /* ── DOM refs ────────────────────────────────────────────── */
    const bubble    = document.getElementById('vl-chat-bubble');
    const msgs      = document.getElementById('vl-chat-msgs');
    const input     = document.getElementById('vl-chat-input');
    const sendBtn   = document.getElementById('vl-send-btn');
    const badge     = document.getElementById('vl-chat-badge');
    const quickReps = document.getElementById('vl-quick-replies');

    /* ── TOGGLE ──────────────────────────────────────────────── */
    window.vlToggle = function () {
        isOpen = !isOpen;
        bubble.classList.toggle('open', isOpen);
        badge.style.display = 'none';
        if (isOpen) {
            if (!hasShownWelcome) {
                hasShownWelcome = true;
                setTimeout(() => {
                    vlAddBotMsg("👋 Hi! I'm your **Camp Assistant** for **Vasota Lake Camping**!\n\nI can help you with:\n• 🏕️ Tent options & pricing\n• 📅 Booking process\n• 📍 Location & activities\n• 💳 Payment info\n\nWhat would you like to know?");
                }, 300);
            }
            setTimeout(() => input.focus(), 400);
        }
    };

    /* Show badge after 3s to attract attention */
    setTimeout(() => {
        if (!isOpen) { badge.style.display = 'flex'; }
    }, 3000);

    /* ── SEND ────────────────────────────────────────────────── */
    window.vlSend = async function () {
        const text = input.value.trim();
        if (!text || isBotTyping) return;

        quickReps.style.display = 'none';
        vlAddUserMsg(text);
        input.value = '';
        vlAutoResize(input);

        await vlGetResponse(text);
    };

    window.vlQuickSend = function (text) {
        if (isBotTyping) return;
        quickReps.style.display = 'none';
        vlAddUserMsg(text);
        vlGetResponse(text);
    };

    /* ── GEMINI API CALL ─────────────────────────────────────── */
    async function vlGetResponse(userText) {
        isBotTyping = true;
        sendBtn.disabled = true;

        // Add to history
        conversationHistory.push({ role: "user", parts: [{ text: userText }] });

        // Show typing indicator
        const typingEl = vlAddTyping();

        try {
            const body = {
                system_instruction: { parts: [{ text: SYSTEM_PROMPT }] },
                contents: conversationHistory,
                generationConfig: {
                    temperature: 0.7,
                    maxOutputTokens: 400,
                    topP: 0.9
                },
                safetySettings: [
                    { category: "HARM_CATEGORY_HARASSMENT",        threshold: "BLOCK_MEDIUM_AND_ABOVE" },
                    { category: "HARM_CATEGORY_HATE_SPEECH",       threshold: "BLOCK_MEDIUM_AND_ABOVE" },
                    { category: "HARM_CATEGORY_SEXUALLY_EXPLICIT", threshold: "BLOCK_MEDIUM_AND_ABOVE" },
                    { category: "HARM_CATEGORY_DANGEROUS_CONTENT", threshold: "BLOCK_MEDIUM_AND_ABOVE" }
                ]
            };

            const res = await fetch(API_URL, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(body)
            });

            if (!res.ok) {
                const errData = await res.json().catch(() => ({}));
                throw new Error(errData.error?.message || ("API error " + res.status));
            }

            const data = await res.json();
            const botText = data.candidates?.[0]?.content?.parts?.[0]?.text
                            || "I'm having trouble responding right now. Please try again!";

            // Add bot reply to history
            conversationHistory.push({ role: "model", parts: [{ text: botText }] });

            // Keep history manageable (last 20 turns)
            if (conversationHistory.length > 20) {
                conversationHistory = conversationHistory.slice(-20);
            }

            vlRemoveTyping(typingEl);
            vlAddBotMsg(botText);

        } catch (err) {
            vlRemoveTyping(typingEl);
            console.error('[Chatbot Error]', err);

            let errMsg = "⚠️ Something went wrong. ";
            if (err.message.includes('API key')) {
                errMsg += "Please check the API key configuration.";
            } else if (err.message.includes('quota') || err.message.includes('429')) {
                errMsg += "Usage limit reached. Please try again in a moment.";
            } else if (!navigator.onLine) {
                errMsg += "You appear to be offline. Please check your connection.";
            } else {
                errMsg += "Please try again or contact us at 📞 9579350747.";
            }
            vlAddBotMsg(errMsg);
            // Remove failed message from history
            conversationHistory.pop();
        } finally {
            isBotTyping = false;
            sendBtn.disabled = false;
            input.focus();
        }
    }

    /* ── UI HELPERS ──────────────────────────────────────────── */
    function vlAddUserMsg(text) {
        const div = document.createElement('div');
        div.className = 'vl-msg user';
        div.innerHTML =
            '<div>' +
                '<div class="vl-bubble">' + vlEscape(text) + '</div>' +
                '<div class="vl-msg-time">' + vlTime() + '</div>' +
            '</div>' +
            '<div class="vl-msg-avatar">&#x1F464;</div>';
        msgs.appendChild(div);
        vlScroll();
    }

    function vlAddBotMsg(text) {
        const div = document.createElement('div');
        div.className = 'vl-msg bot';
        div.innerHTML =
            '<div class="vl-msg-avatar">&#x1F3D5;&#xFE0F;</div>' +
            '<div>' +
                '<div class="vl-bubble">' + vlFormat(text) + '</div>' +
                '<div class="vl-msg-time">' + vlTime() + '</div>' +
            '</div>';
        msgs.appendChild(div);
        vlScroll();
    }

    function vlAddTyping() {
        const div = document.createElement('div');
        div.className = 'vl-msg bot vl-typing';
        div.id = 'vl-typing-indicator';
        div.innerHTML =
            '<div class="vl-msg-avatar">&#x1F3D5;&#xFE0F;</div>' +
            '<div class="vl-bubble">' +
                '<span class="vl-typing-dot"></span>' +
                '<span class="vl-typing-dot"></span>' +
                '<span class="vl-typing-dot"></span>' +
            '</div>';
        msgs.appendChild(div);
        vlScroll();
        return div;
    }

    function vlRemoveTyping(el) {
        if (el && el.parentNode) el.parentNode.removeChild(el);
    }

    /* ── FORMAT MARKDOWN-LITE ────────────────────────────────── */
    function vlFormat(text) {
        return text
            .replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;')   // escape HTML
            .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')                   // **bold**
            .replace(/\*(.+?)\*/g, '<em>$1</em>')                               // *italic*
            .replace(/`(.+?)`/g, '<code style="background:#f0f0f0;padding:1px 4px;border-radius:3px;font-size:12px">$1</code>')
            .replace(/^#{1,3}\s(.+)$/gm, '<strong>$1</strong>')                 // headings
            .replace(/^[•\-]\s(.+)$/gm, '• $1')                                // bullets
            .replace(/\n/g, '<br>');                                             // line breaks
    }

    function vlEscape(text) {
        return text.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/\n/g,'<br>');
    }

    function vlTime() {
        return new Date().toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' });
    }

    function vlScroll() {
        setTimeout(() => { msgs.scrollTop = msgs.scrollHeight; }, 50);
    }

    /* ── INPUT HELPERS ───────────────────────────────────────── */
    window.vlHandleKey = function (e) {
        if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); vlSend(); }
    };

    window.vlAutoResize = function (el) {
        el.style.height = 'auto';
        el.style.height = Math.min(el.scrollHeight, 80) + 'px';
    };

    window.vlClearChat = function () {
        msgs.innerHTML = '';
        conversationHistory = [];
        quickReps.style.display = 'flex';
        hasShownWelcome = false;
        vlAddBotMsg("🗑️ Chat cleared! How can I help you?");
    };

    /* ── KEYBOARD SHORTCUT: Ctrl+/ to open chatbot ───────────── */
    document.addEventListener('keydown', function(e) {
        if ((e.ctrlKey || e.metaKey) && e.key === '/') {
            e.preventDefault();
            vlToggle();
        }
    });

})();
</script>
