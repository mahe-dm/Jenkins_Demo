FROM python:3.9

# Install Firefox
RUN apt-get update && apt-get install -y firefox-esr

# Install geckodriver
RUN GECKODRIVER_VERSION=$(curl -sS https://api.github.com/repos/mozilla/geckodriver/releases/latest | grep tag_name | cut -d '"' -f 4) \
    && wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz \
    && tar -xzf geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin \
    && rm geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz

# Set up the working directory
WORKDIR /app

# Copyb the requirements and install them
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the test file
COPY test_demo_website.py .

# Run the tests
CMD ["pytest", "test_demo_website.py"]

