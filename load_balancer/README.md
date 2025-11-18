# Load Balancer Project

This project sets up a basic load balancer using HAProxy to distribute traffic between two web servers (web-01 and web-02). It also configures the web servers to add a custom HTTP header (`X-Served-By`) with their hostname for tracking requests.

## Project Structure

- `0-custom_http_response_header`: Bash script to configure Nginx on web servers to add the custom `X-Served-By` header.
- `1-install_load_balancer`: Bash script to install and configure HAProxy on the load balancer server (lb-01).

## Requirements

- Ubuntu 16.04 LTS
- Nginx installed on web servers
- HAProxy on the load balancer server
- Proper hostnames set (e.g., `6924-web-01`, `6924-web-02`, `6924-lb-01`)

## Usage

1. **Configure Web Servers**:
   - Run `./0-custom_http_response_header` on web-01 and web-02 to add the custom header.

2. **Install Load Balancer**:
   - Run `./1-install_load_balancer` on lb-01 to set up HAProxy with roundrobin balancing.

3. **Test**:
   - Use `curl -I <lb-01 IP>` to verify load balancing and the `X-Served-By` header.

## Example Output

