import pygame
import sys

# Initialize Pygame
pygame.init()

# Constants
GRID_SIZE = 20
CELL_SIZE = 30
GRID_WIDTH = GRID_SIZE * CELL_SIZE
SIDEBAR_WIDTH = 150
BUTTON_HEIGHT = 80
WINDOW_WIDTH = GRID_WIDTH + SIDEBAR_WIDTH
WINDOW_HEIGHT = GRID_WIDTH + BUTTON_HEIGHT

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
GRAY = (200, 200, 200)
LIGHT_GRAY = (240, 240, 240)
DARK_GRAY = (100, 100, 100)
BLUE = (100, 150, 255)
LIGHT_BLUE = (150, 200, 255)

# Create window
screen = pygame.display.set_mode((WINDOW_WIDTH, WINDOW_HEIGHT))
pygame.display.set_caption("Drawing Grid")

# Grid state (0 = empty, 1 = filled)
grid = [[0 for _ in range(GRID_SIZE)] for _ in range(GRID_SIZE)]

# Tool state
is_drawing_mode = True  # True = draw, False = erase

# Font
font = pygame.font.Font(None, 24)
small_font = pygame.font.Font(None, 20)

def draw_grid():
    """Draw the 20x20 grid"""
    for row in range(GRID_SIZE):
        for col in range(GRID_SIZE):
            x = col * CELL_SIZE
            y = row * CELL_SIZE
            
            # Draw filled cell or empty cell
            if grid[row][col] == 1:
                pygame.draw.rect(screen, BLACK, (x, y, CELL_SIZE, CELL_SIZE))
            else:
                pygame.draw.rect(screen, WHITE, (x, y, CELL_SIZE, CELL_SIZE))
            
            # Draw grid lines
            pygame.draw.rect(screen, GRAY, (x, y, CELL_SIZE, CELL_SIZE), 1)

def draw_tool_selector():
    """Draw the draw/erase pill switch on the right sidebar"""
    switch_x = GRID_WIDTH + 10
    switch_y = 50
    switch_width = 130
    switch_height = 80
    
    # Title
    title = small_font.render("Tool:", True, BLACK)
    screen.blit(title, (switch_x + 10, switch_y - 30))
    
    # Draw mode button (top half)
    draw_color = BLUE if is_drawing_mode else LIGHT_GRAY
    pygame.draw.rect(screen, draw_color, (switch_x, switch_y, switch_width, switch_height // 2), border_radius=10)
    pygame.draw.rect(screen, DARK_GRAY, (switch_x, switch_y, switch_width, switch_height // 2), 2, border_radius=10)
    
    draw_text = small_font.render("Draw", True, WHITE if is_drawing_mode else BLACK)
    text_rect = draw_text.get_rect(center=(switch_x + switch_width // 2, switch_y + switch_height // 4))
    screen.blit(draw_text, text_rect)
    
    # Erase mode button (bottom half)
    erase_color = BLUE if not is_drawing_mode else LIGHT_GRAY
    pygame.draw.rect(screen, erase_color, (switch_x, switch_y + switch_height // 2, switch_width, switch_height // 2), border_radius=10)
    pygame.draw.rect(screen, DARK_GRAY, (switch_x, switch_y + switch_height // 2, switch_width, switch_height // 2), 2, border_radius=10)
    
    erase_text = small_font.render("Erase", True, WHITE if not is_drawing_mode else BLACK)
    text_rect = erase_text.get_rect(center=(switch_x + switch_width // 2, switch_y + 3 * switch_height // 4))
    screen.blit(erase_text, text_rect)
    
    return (switch_x, switch_y, switch_width, switch_height)

def draw_predict_button():
    """Draw the predict button at the bottom"""
    button_x = 10
    button_y = GRID_WIDTH + 10
    button_width = WINDOW_WIDTH - 20
    button_height = 40
    
    pygame.draw.rect(screen, LIGHT_BLUE, (button_x, button_y, button_width, button_height), border_radius=5)
    pygame.draw.rect(screen, BLUE, (button_x, button_y, button_width, button_height), 3, border_radius=5)
    
    text = font.render("PREDICT", True, BLACK)
    text_rect = text.get_rect(center=(button_x + button_width // 2, button_y + button_height // 2))
    screen.blit(text, text_rect)
    
    return (button_x, button_y, button_width, button_height)

def handle_grid_click(pos, is_dragging=False):
    """Handle clicking or dragging on the grid"""
    x, y = pos
    
    # Check if click is within grid bounds
    if x < GRID_WIDTH and y < GRID_WIDTH:
        col = x // CELL_SIZE
        row = y // CELL_SIZE
        
        if 0 <= row < GRID_SIZE and 0 <= col < GRID_SIZE:
            if is_drawing_mode:
                grid[row][col] = 1
            else:
                grid[row][col] = 0

def get_grid_array():
    """Convert grid to 400-length array"""
    arr = []
    for row in range(GRID_SIZE):
        for col in range(GRID_SIZE):
            arr.append(grid[row][col])
    return arr

def predict(array):
    print("Grid Array (400 elements):")
    print(arr)
    

# Main game loop
clock = pygame.time.Clock()
running = True
mouse_pressed = False

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        
        elif event.type == pygame.MOUSEBUTTONDOWN:
            if event.button == 1:  # Left mouse button
                mouse_pressed = True
                pos = pygame.mouse.get_pos()
                
                # Check if predict button was clicked
                btn_x, btn_y, btn_w, btn_h = (10, GRID_WIDTH + 10, WINDOW_WIDTH - 20, 40)
                if btn_x <= pos[0] <= btn_x + btn_w and btn_y <= pos[1] <= btn_y + btn_h:
                    arr = get_grid_array()
                    predict(arr)
                
                # Check if tool selector was clicked
                elif pos[0] >= GRID_WIDTH:
                    switch_x = GRID_WIDTH + 10
                    switch_y = 50
                    switch_width = 100
                    switch_height = 80
                    
                    if switch_x <= pos[0] <= switch_x + switch_width:
                        if switch_y <= pos[1] <= switch_y + switch_height // 2:
                            is_drawing_mode = True
                        elif switch_y + switch_height // 2 <= pos[1] <= switch_y + switch_height:
                            is_drawing_mode = False
                
                # Otherwise handle grid click
                else:
                    handle_grid_click(pos)
        
        elif event.type == pygame.MOUSEBUTTONUP:
            if event.button == 1:
                mouse_pressed = False
        
        elif event.type == pygame.MOUSEMOTION:
            if mouse_pressed:
                handle_grid_click(pygame.mouse.get_pos(), is_dragging=True)
    
    # Clear screen
    screen.fill(LIGHT_GRAY)
    
    # Draw everything
    draw_grid()
    draw_tool_selector()
    draw_predict_button()
    
    # Update display
    pygame.display.flip()
    clock.tick(60)

pygame.quit()
sys.exit()