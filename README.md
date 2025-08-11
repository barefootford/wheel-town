# SF Ruby AI Hackathon 

This application was created as part of San Francisco Ruby Meetups 2025 AI Hackathon. It won third place. The programmers who created this are Andrew Ford and Nate Tate.

# WheelTown

WheelTown is a web application for collecting and analyzing automated bike lane usage statistics. It helps urban planners, transportation researchers, and advocacy groups gather comprehensive data about cycling infrastructure usage through photo-based data collection and AI-powered analysis.


## Features

### Recording Sessions
- Create timed recording sessions at specific locations
- Track session duration with start/end times
- Aggregate data across bicyclist, scooter, jogger, etc trips in the bike lane

### Automated Trip Analysis
- Upload photos of bike lane users
- AI-powered image analysis using GPT-4 Vision to automatically extract:
  - Vehicle type (bicycle, e-bike, cargo bike, scooter, skateboard, etc.)
  - Electric vehicle identification
  - Helmet usage detection
  - Clothing style (athletic vs casual)
  - Gender presentation based on clothing
  - Passenger count
  - Age category (child vs adult)

### Comprehensive Analytics Dashboard
- Total trip counts and breakdowns
- Helmet usage statistics
- Electric vehicle adoption rates
- Child rider percentages
- Vehicle type distribution charts
- Gender presentation distribution
- Time-based usage patterns

### Privacy-First Design
- Child photos are never displayed (shows generic icon instead)
- Focus on aggregate statistics, not individual identification
- No personal data collection beyond observational categories

## Technology Stack

- **Ruby on Rails 8.0.2** - Web application framework
- **SQLite** - Database
- **Tailwind CSS** - Styling
- **Hotwire (Turbo & Stimulus)** - Modern Rails interactivity
- **Active Storage with AWS S3** - Image storage
- **OpenAI GPT-4 Vision API** - Automated image analysis

## Getting Started

### Prerequisites

- Ruby 3.x
- Rails 8.0.2
- SQLite3

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/wheel-town.git
cd wheel-town
```

2. Install dependencies:
```bash
bundle install
```

3. Set up the database:
```bash
rails db:create
rails db:migrate
```

4. Configure environment variables:
Create a `.env` file with the following:
```
WASABI_ACCESS_KEY_ID=123
WASABI_SECRET_ACCESS_KEY=123
OPENAI_API_KEY=sk-proj-123
```

5. Start the Rails server:
```bash
rails server
```

Visit `http://localhost:3000` to start using WheelTown.

## Usage

1. **Create a Recording**: Click "New Recording" and fill in the location details and session information.

2. **Add Trips**: During your recording session, upload photos of bike lane users as they pass by.

3. **View Analytics**: Access the statistics dashboard to see comprehensive breakdowns of:
   - Vehicle types and usage patterns
   - Safety compliance (helmet usage)
   - Demographics and user characteristics
   - Time-based trends

4. **Export Data**: Use the analytics to inform infrastructure decisions and advocacy efforts.

## Use Cases

- **Urban Planning**: Collect data to justify bike lane improvements or expansions
- **Safety Advocacy**: Track helmet usage and identify areas needing safety campaigns
- **Infrastructure Research**: Understand vehicle type diversity and electric adoption
- **Grant Applications**: Provide data-driven evidence for funding requests

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built with Rails and modern web technologies
- Powered by OpenAI's GPT-4 Vision for automated analysis
- Designed with privacy and ethical data collection in mind
