
void test_entry() {
}

void main() {
    // add 2 to get next vid mem location

    char* video_memory = (char*) 0xb8000 + 2;
    *video_memory = 'A';
}