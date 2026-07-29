<h1>🏠 Smart Home Digital Twin</h1>
<img width="1279" height="747" alt="Screenshot 2026-07-28 194349" src="https://github.com/user-attachments/assets/2f2d87ba-314e-475e-8d3e-6968ece74f7f" />

<h2>The Architecture</h2>
<p>The system is decoupled into two separate applications to mimic real-world IoT environments:</p>
<ul>
    <li><strong>3D Simulation Server ("The Home"):</strong> Renders the 3D interior (living room) and exterior (villa) using Qt Quick 3D. It handles the environmental simulation and streams a live camera view.</li>
    <li><strong>Dashboard Client ("The Control Center"):</strong> A clean UI featuring device toggles, a thermostat controller, a live CCTV feed, and layout space for future energy/weather tracking.</li>
</ul>

<h2>How do they communicate?</h2>
<ul>
    <li><strong>WebSockets (Instant Sync):</strong> Handles two-way telemetry for device states. When you toggle a light or open a door on the dashboard, the 3D world reacts with zero delay.</li>
    <li><strong>FFmpeg + UDP (CCTV Stream):</strong> The 3D app encodes frames via FFmpeg and streams them over UDP. The natural encoding/decoding process adds a slight, intentional delay, perfectly mimicking a real-world security camera.</li>
</ul>

<h2>✨ Key Features</h2>
<ul>
    <li><strong>Two-Way Synchronization:</strong> Changes in the 3D environment reflect on the dashboard, and dashboard controls instantly manipulate the 3D world.</li>
    <li><strong>Visual Thermostat Logic:</strong> Four functional modes (Auto, Heat, Cool, Eco) that adjust the room's temperature and trigger vivid particle effects in the 3D scene (e.g., red particles for 35°C heat, blue for 10°C cool).</li>
    <li><strong>Device Control:</strong> Manage interior/exterior lights, the main door, and the garage door.</li>
</ul>

<h2>🛠️ Tech Stack</h2>
<ul>
    <li><strong>Core:</strong> Qt 6, C++, QML, Qt Quick 3D</li>
    <li><strong>Networking & Media:</strong> WebSockets, FFmpeg (H.264), UDP</li>
    <li><strong>Future Scope:</strong> SQLite + QGraph for energy and weather data visualizations</li>
</ul>
<img width="638" height="508" alt="01-6476a413f77a8674c03d3b5ef4ac5c7a" src="https://github.com/user-attachments/assets/f26f8b43-8c9a-4952-9324-382d2c4c0843" />
<img width="1539" height="724" alt="Screenshot 2026-04-14 203904-1bf0d7f93f978b8f853a2e7b83149a23" src="https://github.com/user-attachments/assets/c367df80-b684-4227-9c74-91e1b69790fa" />
<img width="1073" height="743" alt="Screenshot 2026-04-14 203956-b65cba21cb98be6676bf49be0072b77b" src="https://github.com/user-attachments/assets/1abdd763-94dd-4f3b-a839-7b8fb2152359" />
