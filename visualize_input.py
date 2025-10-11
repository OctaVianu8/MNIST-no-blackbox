import pygame
import sys

# --- CONFIG ---
GRID_SIZE = 20
CELL_SIZE = 25
MARGIN = 1
WINDOW_SIZE = GRID_SIZE * (CELL_SIZE + MARGIN) + MARGIN
FILE_PATH = "data.txt"

def read_array(filename):
    with open(filename, "r") as f:
        data = f.read().split()
    arr = [float(x) for x in data]
    if len(arr) != 400:
        raise ValueError(f"Expected 400 values, got {len(arr)}")
    return arr

def value_to_alpha(v):
    # Map [-2, 2] -> [0, 255]
    a = int(((v + 2) / 4) * 255)
    return max(0, min(a, 255))

def main():
    data = read_array(FILE_PATH)

    pygame.init()
    screen = pygame.display.set_mode((WINDOW_SIZE, WINDOW_SIZE))
    pygame.display.set_caption("20x20 Grid (Opacity from -2 to 2)")

    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

        screen.fill((30, 30, 30))

        for i in range(GRID_SIZE):
            for j in range(GRID_SIZE):
                idx = i * GRID_SIZE + j
                val = data[idx]
                alpha = value_to_alpha(val)

                cell = pygame.Surface((CELL_SIZE, CELL_SIZE), pygame.SRCALPHA)
                cell.fill((0, 0, 0, alpha))

                x = MARGIN + j * (CELL_SIZE + MARGIN)
                y = MARGIN + i * (CELL_SIZE + MARGIN)
                screen.blit(cell, (x, y))

        pygame.display.flip()

    pygame.quit()
    sys.exit()

if __name__ == "__main__":
    main()
